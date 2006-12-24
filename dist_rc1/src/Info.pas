unit Info;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw;

type
  TForm4 = class(TForm)
    WebBrowser1: TWebBrowser;
  private
    { Private declarations }
  public
    procedure Go(url: String);
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.Go(url: String);
begin
  WebBrowser1.Navigate(url);
  Show;
end;

end.
