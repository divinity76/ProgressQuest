unit Front;
{ copyright (c)2002 Eric Fredricksen all rights reserved }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFrontForm = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    Button4: TButton;
    Label2: TLabel;
    Button3: TButton;
    Panel2: TPanel;
    Logo: TImage;
    Label3: TLabel;
    HomeLink: TLabel;
    Label1: TLabel;
    procedure HomeLinkClick(Sender: TObject);
    procedure LogoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrontForm: TFrontForm;

implementation

uses ShellAPI, Main, Info;

{$R *.dfm}

procedure TFrontForm.HomeLinkClick(Sender: TObject);
begin
	ShellExecute(GetDesktopWindow(), 'open', 'http://progressquest.com/', nil, '', SW_SHOW);
end;

procedure TFrontForm.LogoClick(Sender: TObject);
begin
	ShellExecute(GetDesktopWindow(), 'open', 'http://progressquest.com/', nil, '', SW_SHOW);
end;

end.
