program Project1;

var
  mr : CMem_reader;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  translator in 'translator.pas' {/consts in 'consts.pas'},
  d3ui in 'd3ui.pas';



{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
