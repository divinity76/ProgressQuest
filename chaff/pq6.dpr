program pq6;



uses
  Forms,
  Classes,
  Main in 'Main.pas' {Form1},
  NewGuy in 'NewGuy.pas' {Form2},
  Config in 'Config.pas' {K},
  Front in 'Front.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Progress Quest VI';
  if ParamCount > 0 then begin
    Form1.LoadGame(ParamStr(1));
  end else begin
    Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  end;
  Application.CreateForm(TK, K);
  Application.Run;
end.
