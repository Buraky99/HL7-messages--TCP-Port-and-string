program ServerHL7;

uses
  Vcl.Forms,
  ServerHl in 'ServerHl.pas' {Form13};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm13, Form13);
  Application.Run;
end.



