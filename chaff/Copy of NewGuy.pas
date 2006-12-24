unit NewGuy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Psock, NMHttp, NMURL;

type
  TForm2 = class(TForm)
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
    GroupBox2: TGroupBox;
    GameStyle: TTrackBar;
    Label9: TLabel;
    Label10: TLabel;
    Name: TLabeledEdit;
    OldRolls: TListBox;
    Button2: TButton;
    Server: TNMHTTP;
    Online: TCheckBox;
    PoorCodeDesign: TNMURL;
    procedure RerollClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure UnrollClick(Sender: TObject);
    procedure ServerSuccess(Cmd: CmdType);
    procedure SoldClick(Sender: TObject);
  private
    procedure RollEm;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

function UrlEncode(s: string): string;

implementation

uses Main;

{$R *.dfm}

function UrlEncode(s: string): string;
begin
  Form2.PoorCodeDesign.InputString := s;
  Result := Form2.PoorCodeDesign.Encode;
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

procedure TForm2.RollEm;
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

procedure TForm2.RerollClick(Sender: TObject);
begin
  OldRolls.Items.Insert(0, IntToStr(ReRoll.Tag));
  Unroll.Enabled := true;
  RollEm;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  Randomize;
  RollEm;
  with Race do
    ItemIndex := Random(Items.Count);
  with Klass do
    ItemIndex := Random(Items.Count);
  Name.SetFocus;
end;

procedure TForm2.UnrollClick(Sender: TObject);
begin
  RandSeed := StrToInt(OldRolls.Items[0]);
  OldRolls.Items.Delete(0);
  Unroll.Enabled := OldRolls.Items.Count > 0;
  RollEm;
end;

procedure TForm2.ServerSuccess(Cmd: CmdType);
begin
  if (LowerCase(Split(Server.Body,0)) = 'ok') then begin
    Form1.Traits.Hint := Split(Server.Body,1);
    Form1.Traits.Tag := StrToInt(Form1.Traits.Hint);
    Server.OnSuccess := nil;
    Server.OnFailure := nil;
    ModalResult := mrOk;
  end else begin
    ShowMessage(Split(Server.Body,1));
  end;
end;

procedure TForm2.SoldClick(Sender: TObject);
begin
  if not Online.Checked
  then ModalResult := mrOk
  else begin
    try
      Screen.Cursor := crHourglass;
      try
        Server.Get('http://progressquest.name2host.com/hi.php?cmd=create&name=' + UrlEncode(Name.Text));
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

end.
