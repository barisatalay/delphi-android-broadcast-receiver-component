unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  BroadcastReceiver, FMX.StdCtrls
   {$IFDEF ANDROID}
  ,Androidapi.JNI.GraphicsContentViewText
  ,Androidapi.Helpers
  ,Androidapi.JNI.Telephony
  ,Androidapi.JNI.JavaTypes
  ,Androidapi.JNIBridge

  ,Androidapi.JNI.Os
  {$ENDIF}
  ;

type
  TMainScreen = class(TForm)
    BroadcastReceiver2: TBroadcastReceiver;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure BroadcastReceiver2Receive(Context: JContext; Intent: JIntent);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Const
  PHONE_STATE ='android.intent.action.PHONE_STATE';

var
  MainScreen: TMainScreen;

implementation

{$R *.fmx}

uses ToastAndroid;


procedure TMainScreen.BroadcastReceiver2Receive(Context: JContext;
  Intent: JIntent);
{$IFDEF ANDROID}
var
  telephonyManager: JTelephonyManager;
  obj: JObject;
  Temp: String;
begin
  if not BroadcastReceiver2.HasPermission('android.permission.READ_PHONE_STATE') then
  begin
    ShowMessage('You don''t have permission for Read Phone State!');
    Exit;
  end;

  Obj := SharedActivityContext.getSystemService(TJContext.JavaClass.TELEPHONY_SERVICE);
  telephonyManager := TJTelephonyManager.Wrap( (obj as ILocalObject).GetObjectID );

  Temp := JStringToString(intent.getStringExtra(StringToJString('incoming_number')));
  if Temp.Length > 0 then
    Toast('In coming call number: '+Temp,TToastLength.ShortToast)
  else
    Toast('No Number..',TToastLength.ShortToast);
{$ELSE}
begin
{$ENDIF}
end;

procedure TMainScreen.Button1Click(Sender: TObject);
begin
  BroadcastReceiver2.Add(PHONE_STATE);
end;

procedure TMainScreen.Button2Click(Sender: TObject);
begin
  BroadcastReceiver2.SendBroadcast(PHONE_STATE)
end;

procedure TMainScreen.Button3Click(Sender: TObject);
begin
  BroadcastReceiver2.RegisterReceive;
end;

end.
