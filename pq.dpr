program pq;

uses
  Forms,
  Config in 'Config.pas' {K},
  Front in 'Front.pas' {Form3},
  Main in 'Main.pas' {Form1},
  NewGuy in 'NewGuy.pas' {Form2};

{$E exe}

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Progress Quest';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TK, K);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
