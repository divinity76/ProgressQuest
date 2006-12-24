unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm3 = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    OpenDialog1: TOpenDialog;
    Button4: TButton;
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses ShellAPI, Main;

{$R *.dfm}

procedure TForm3.Button3Click(Sender: TObject);
begin
  ShellExecute(Form1.Handle, 0, PChar('res://' + Application.ExeName + '/6'), 0, 0, SW_SHOWNORMAL);
end;

end.
