program TTLockApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  App.MainForm in 'src/App.MainForm.pas' {FormMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.

