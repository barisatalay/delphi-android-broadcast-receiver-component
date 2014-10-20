unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  BroadcastReceiver
  {$IFDEF ANDROID}
  ,Androidapi.JNI.GraphicsContentViewText
  ,Androidapi.Helpers
  ,Androidapi.JNI.Telephony
  ,Androidapi.JNI.JavaTypes
  ,Androidapi.JNIBridge
  ,FMX.Helpers.Android
  {$ENDIF}
  ;

type
  TForm4 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    BroadcastReceiver1: TBroadcastReceiver;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BroadcastReceiver1Receive(Context: JContext; Intent: JIntent);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Const
  PHONE_STATE ='android.intent.action.PHONE_STATE';

var
  Form4: TForm4;

implementation

{$R *.fmx}

uses ToastAndroid;

procedure TForm4.BroadcastReceiver1Receive(Context: JContext; Intent: JIntent);
{$IFDEF ANDROID}
var
  telephonyManager: JTelephonyManager;
  obj: JObject;
  Temp: String;
begin
  if not BroadcastReceiver1.HasPermission('android.permission.READ_PHONE_STATE') then
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

procedure TForm4.Button1Click(Sender: TObject);
begin
  BroadcastReceiver1.RegisterReceive;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  BroadcastReceiver1.SendBroadcast(PHONE_STATE);
end;

procedure TForm4.Button3Click(Sender: TObject);
begin
  BroadcastReceiver1.Add(PHONE_STATE);
end;

end.
