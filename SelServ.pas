unit SelServ;
{ copyright (c)2002 Eric Fredricksen all rights reserved }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Psock, NMHttp;

type
  TServerSelectForm = class(TForm)
    Servers: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Desc: TRichEdit;
    Select: TButton;
    Button2: TButton;
    ServerLoader: TNMHTTP;
    Descs: TListBox;
    Timer1: TTimer;
    Hosts: TListBox;
    Options: TListBox;
    AccessCode: TLabeledEdit;
    procedure ServerLoaderSuccess(Cmd: CmdType);
    procedure ServersClick(Sender: TObject);
    procedure SelectClick(Sender: TObject);
    procedure AccessCodeChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ServersDblClick(Sender: TObject);
  private
    procedure Fetch(path: String);
    function CurrentOpts: Integer;
  public
    function Go: Boolean;
  end;

var
  ServerSelectForm: TServerSelectForm;

function Take(var s: String): String;

implementation

uses NewGuy, Login, Main;

{$R *.dfm}

function Take(var s: String): String;
begin
  if Pos('|',s) > 0 then begin
    Result := Trim(Copy(s,1,Pos('|',s)-1));
    s := Copy(s,Pos('|',s)+1,100000);
  end else begin
    Result := Trim(s);
    s := '';
  end;
end;

procedure TServerSelectForm.ServerLoaderSuccess(Cmd: CmdType);
var
  s, def: String;
  ndef: Integer;
begin
  s := ServerLoader.Body;
  if (LowerCase(Take(s)) = 'ok') then begin
    def := Take(s);
    ndef := 0;
    repeat
      Servers.Items.Add(Take(s));
      if Servers.Items[Servers.Count-1] = def then
        ndef := Servers.Count-1;
      Options.Items.Add(Take(s));
      Hosts.Items.Add(Take(s));
      Descs.Items.Add(Take(s));
    until s = '';
    Servers.ItemIndex := ndef;
    ServersClick(Self);
    // Select.Enabled := true;
  end else begin
    ShowMessage(ServerLoader.Body);
    ModalResult := mrCancel;
  end;
end;

procedure TServerSelectForm.ServersClick(Sender: TObject);
begin
  Desc.Lines.Text := Descs.Items[Servers.ItemIndex];
  AccessCode.Visible := (CurrentOpts and 8) > 0;
  AccessCodeChange(Sender);
end;

function TServerSelectForm.CurrentOpts: Integer;
begin
  Result := StrToIntDef(Options.Items[Servers.ItemIndex],0);
end;

procedure TServerSelectForm.Fetch(path: String);
begin
  Select.Enabled := false;
  Servers.Items.Clear;
  Descs.Items.Clear;
  Options.Items.Clear;
  Hosts.Items.Clear;
  Caption := 'Progress Quest - Select Realm';
  if path <> '' then
    Caption := Caption + ' [' + path + ']';
  Desc.Text := 'Fetching realm list from server...';
  try
    Screen.Cursor := crHourglass;
    try
      if AccessCode.Visible
      then ServerLoader.HeaderInfo.Password := AccessCode.Text
      else ServerLoader.HeaderInfo.Password := '';
      ServerLoader.Get('http://www.progressquest.com/list.php?' + RevString + '&p=' + path +'&ac=' + UrlEncode(ServerLoader.HeaderInfo.Password));
    except
      on ESockError do begin
        ShowMessage('Error connecting to server');
        ServerLoader.Abort;
        ModalResult := mrCancel;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function TServerSelectForm.Go: Boolean;
begin
  Timer1.Enabled := true;
  Result := //(Servers.Count > 0) and
    (mrOk = ShowModal);
end;

function ServerURL(user, pass, host, uri: String): String;
begin
  if Pos(uri, '?') > 0 then uri := uri + '&' else uri := uri + '?';
  uri := uri + 'rev=3';
  Result := 'http://' + user + ':' + pass + '@' + host + uri;
end;

procedure TServerSelectForm.AccessCodeChange(Sender: TObject);
begin
  Select.Enabled :=
    (CurrentOpts and 32 = 0) and
    (Servers.Count > 0) and (
      (not AccessCode.Visible) or
      (AccessCode.Text <> ''));
end;

procedure TServerSelectForm.SelectClick(Sender: TObject);
begin
  // 1: account required to create char
  // 2: password required to create char
  // 4: is a dir
  // 8: password required to select
  // 16: use progressquest.com for creates!
  // 32: disable it!
  if (CurrentOpts and 4) > 0 then begin
    Fetch(Hosts.Items[Servers.ItemIndex]);
  end else begin
    MainForm.SetHostAddr(Hosts.Items[Servers.ItemIndex]);
    MainForm.SetHostName(Servers.Items[Servers.ItemIndex]);
    MainForm.Label8.Tag := CurrentOpts;
    NewGuyForm.Account.Visible := (CurrentOpts and 1) > 0;
    NewGuyForm.Password.Visible := (CurrentOpts and 2) > 0;
    if MainForm.RollCharacter then
      ModalResult := mrOk;
  end;
end;

procedure TServerSelectForm.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := false;
  Fetch('');
end;

procedure TServerSelectForm.ServersDblClick(Sender: TObject);
begin
  if Select.Enabled then SelectClick(Self);
end;

end.
