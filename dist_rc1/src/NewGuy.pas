unit NewGuy;
{ copyright (c)2002 Eric Fredricksen all rights reserved }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Psock, NMHttp, NMURL, AppEvnts;

type
  TNewGuyForm = class(TForm)
    Race: TRadioGroup;
    Klass: TRadioGroup;
    Label2: TLabel;
    STR: TPanel;
    Label3: TLabel;
    CON: TPanel;
    Label4: TLabel;
    DEX: TPanel;
    Label5: TLabel;
    INT: TPanel;
    Label6: TLabel;
    WIS: TPanel;
    Label7: TLabel;
    CHA: TPanel;
    Reroll: TButton;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Total: TPanel;
    Sold: TButton;
    Unroll: TButton;
    Name: TLabeledEdit;
    OldRolls: TListBox;
    Button2: TButton;
    Server: TNMHTTP;
    PoorCodeDesign: TNMURL;
    Account: TLabeledEdit;
    Password: TLabeledEdit;
    ApplicationEvents1: TApplicationEvents;
    GuildGet: TNMHTTP;
    procedure RerollClick(Sender: TObject);
    procedure UnrollClick(Sender: TObject);
    procedure ServerSuccess(Cmd: CmdType);
    procedure SoldClick(Sender: TObject);
    procedure ServerFailure(Cmd: CmdType);
    procedure FormShow(Sender: TObject);
    procedure ServerAboutToSend(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure GuildGetSuccess(Cmd: CmdType);
  private
    procedure RollEm;
    function GetAccount: String;
    function GetPassword: String;
  public
    procedure BragSuccess(Cmd: CmdType);
    function Go: Boolean;
  end;

var
  NewGuyForm: TNewGuyForm;

function UrlEncode(s: string): string;

implementation

uses Main, SelServ;

{$R *.dfm}

function UrlEncode(s: string): string;
begin
  NewGuyForm.PoorCodeDesign.InputString := s;
  Result := NewGuyForm.PoorCodeDesign.Encode;
end;

procedure Roll(stat: TPanel);
begin
  stat.Tag := 3 + Random(6) + Random(6) + Random(6);
  stat.Caption := IntToStr(stat.Tag);
end;

function Choose(n, k: Integer): Real;
var
  d, i: Longint;
begin
  Result := n;
  d := 1;
  for i := 2 to k do begin
    Result := Result * (1+n-i);
    d := d * i;
  end;
  Result := Result / d;
end;

procedure TNewGuyForm.RollEm;
begin
  ReRoll.Tag := RandSeed;
  Roll(STR);
  Roll(CON);
  Roll(DEX);
  Roll(INT);
  Roll(WIS);
  Roll(CHA);
  Total.tag := STR.Tag + Con.Tag + DEX.Tag + Int.Tag + Wis.Tag + CHA.Tag;
  Total.Caption := IntToStr(Total.Tag);
  if Total.Tag >= (63+18) then Total.Color := clRed
  else if Total.Tag > (4 * 18) then Total.Color := clYellow
  else if Total.Tag <= (63-18) then Total.Color := clGray
  else if Total.Tag < (3 * 18) then Total.Color := clSilver
  else Total.Color := clWhite;
end;

procedure TNewGuyForm.RerollClick(Sender: TObject);
begin
  OldRolls.Items.Insert(0, IntToStr(ReRoll.Tag));
  Unroll.Enabled := true;
  RollEm;
end;

function TNewGuyForm.Go: Boolean;
begin
  Tag := 1;
  Result := mrOk = ShowModal;
end;

procedure TNewGuyForm.FormShow(Sender: TObject);
begin
  if Tag > 0 then begin
    Tag := 0;
    Caption := 'Progress Quest - New Character';
    if MainForm.GetHostName <> '' then
      Caption := Caption + ' [' + MainForm.GetHostName + ']';
    Randomize;
    RollEm;
    with Race do
      ItemIndex := Random(Items.Count);
    with Klass do
      ItemIndex := Random(Items.Count);
    Name.SetFocus;
  end;
end;

procedure TNewGuyForm.UnrollClick(Sender: TObject);
begin
  RandSeed := StrToInt(OldRolls.Items[0]);
  OldRolls.Items.Delete(0);
  Unroll.Enabled := OldRolls.Items.Count > 0;
  RollEm;
end;

procedure TNewGuyForm.ServerSuccess(Cmd: CmdType);
begin
  if (LowerCase(Split(Server.Body,0)) = 'ok') then begin
    MainForm.SetPasskey(Split(Server.Body,1));
    MainForm.SetLogin(GetAccount);
    MainForm.SetPassword(GetPassword);
    Server.OnSuccess := nil;
    Server.OnFailure := nil;
    ModalResult := mrOk;
  end else begin
    ShowMessage(Server.Body);
  end;
end;

procedure TNewGuyForm.BragSuccess(Cmd: CmdType);
begin
  if (LowerCase(Split(Server.Body,0)) = 'report') then
    ShowMessage(Split(Server.Body,1));
end;

function TNewGuyForm.GetAccount: String;
begin
  Result := '';
  if Account.Visible then Result := Account.Text;
end;

function TNewGuyForm.GetPassword: String;
begin
  Result := '';
  if Password.Visible then Result := Password.Text;
end;

procedure TNewGuyForm.SoldClick(Sender: TObject);
var url, args: String;
begin
  if MainForm.GetHostAddr = ''
  then ModalResult := mrOk
  else begin
    try
      Screen.Cursor := crHourglass;
      try
        Server.HeaderInfo.UserId := GetAccount;
        Server.HeaderInfo.Password := GetPassword;
        args := 'cmd=create' +
                '&name=' + UrlEncode(Name.Text) +
                '&realm=' + UrlEncode(MainForm.GetHostName) +
                RevString;
        if (MainForm.Label8.Tag and 16) = 0
        then url := MainForm.GetHostAddr
        else url := 'http://www.progressquest.com/create.php?';
        Server.Get(url + args);
      except
        on ESockError do begin
          ShowMessage('Error connecting to server');
          Server.Abort;
        end;
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TNewGuyForm.ServerFailure(Cmd: CmdType);
begin
  ShowMessage('Connection to server ' + MainForm.GetHostName + ' failed');
end;

procedure TNewGuyForm.ServerAboutToSend(Sender: TObject);
begin
  Server.SendHeader.Values['Content-Type'] := 'text/plain';
  Server.SendHeader.Values['Motto'] := MainForm.GetMotto;
  Server.SendHeader.Values['Guild'] := MainForm.GetGuild;
end;

procedure TNewGuyForm.ApplicationEvents1Minimize(Sender: TObject);
begin
  MainForm.MinimizeIt;
end;

procedure TNewGuyForm.GuildGetSuccess(Cmd: CmdType);
var s,b: string;
begin
  b := GuildGet.Body;
  s := Take(b);
  if s <> '' then ShowMessage(s);
  s := Take(b);
  if s <> '' then Navigate(s);
end;

end.
