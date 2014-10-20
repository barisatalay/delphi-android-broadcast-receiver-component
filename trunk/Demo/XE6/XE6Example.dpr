program XE6Example;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  Main in 'Units\Main.pas' {Form4},
  ToastAndroid in 'Units\ToastAndroid.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
