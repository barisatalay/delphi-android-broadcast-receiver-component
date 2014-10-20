program XE7Example;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Units\Main.pas' {MainScreen},
  ToastAndroid in 'Units\ToastAndroid.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainScreen, MainScreen);
  Application.Run;
end.
