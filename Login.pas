unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Psock, NMHttp;

type
  TLoginForm = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Login: TButton;
    Button1: TButton;
    GroupBox2: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Label3: TLabel;
    GroupBox3: TGroupBox;
    Account: TLabeledEdit;
    Password: TLabeledEdit;
    Label4: TLabel;
    procedure Label2Click(Sender: TObject);
    procedure AccountChange(Sender: TObject);
    procedure LoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoginForm: TLoginForm;

implementation

uses ShellAPI, Main, NewGuy, SelServ;

{$R *.dfm}

procedure TLoginForm.Label2Click(Sender: TObject);
begin
	ShellExecute(GetDesktopWindow(), 'open', PChar(TLabel(Sender).Caption), nil, '', SW_SHOW);
end;

procedure TLoginForm.AccountChange(Sender: TObject);
begin
  Login.Enabled := (Account.Text <> '') and (Password.Text <> '');
end;

procedure TLoginForm.LoginClick(Sender: TObject);
begin
  MainForm.SetLogin(Account.Text);
  MainForm.SetPassword(Password.Text);
  if ServerSelectForm.Go then
    ModalResult := mrOk;
end;

end.
