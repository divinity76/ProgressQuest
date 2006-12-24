unit Front;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm3 = class(TForm)
    Panel1: TPanel;
    Logo: TImage;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    OpenDialog1: TOpenDialog;
    Button4: TButton;
    Label2: TLabel;
    Label3: TLabel;
    HomeLink: TLabel;
    procedure HomeLinkClick(Sender: TObject);
    procedure LogoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses ShellAPI, Main, Info;

{$R *.dfm}

procedure TForm3.HomeLinkClick(Sender: TObject);
begin
	ShellExecute(GetDesktopWindow(), 'open', 'http://progressquest.com/pq.html', 0, '', SW_SHOW);
end;

procedure TForm3.LogoClick(Sender: TObject);
begin
	ShellExecute(GetDesktopWindow(), 'open', 'http://progressquest.com/', 0, '', SW_SHOW);
end;

end.
