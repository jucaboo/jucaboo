unit TTLock.TTLockService.Android;

interface

{$IFDEF ANDROID}

uses
  System.SysUtils, Androidapi.JNI.App, Androidapi.JNIBridge, Androidapi.JNI.JavaTypes,
  Androidapi.Helpers, Androidapi.JNI.Os,
  TTLock.ITTLockService, TTLock.TTLockModels;

type
  TAndroidTTLockService = class(TInterfacedObject, ITTLockService)
  private
    FOnDeviceFound: TTTLockDeviceFoundEvent;
  public
    procedure Initialize(const AppId, AppSecret: string);
    procedure SetOnDeviceFound(const Handler: TTTLockDeviceFoundEvent);
    procedure StartScan;
    procedure StopScan;
    function Connect(const Device: TTTLockDevice): Boolean;
    function Unlock(const Device: TTTLockDevice): Boolean;
  end;

implementation

procedure TAndroidTTLockService.Initialize(const AppId, AppSecret: string);
begin
  // TODO: Initialize TTLock Android SDK with AppId/AppSecret
end;

procedure TAndroidTTLockService.SetOnDeviceFound(const Handler: TTTLockDeviceFoundEvent);
begin
  FOnDeviceFound := Handler;
end;

procedure TAndroidTTLockService.StartScan;
begin
  // TODO: Call TTLock SDK startScan and map callbacks to FOnDeviceFound
end;

procedure TAndroidTTLockService.StopScan;
begin
  // TODO: stop scan
end;

function TAndroidTTLockService.Connect(const Device: TTTLockDevice): Boolean;
begin
  // TODO: connect using SDK
  Result := False;
end;

function TAndroidTTLockService.Unlock(const Device: TTTLockDevice): Boolean;
begin
  // TODO: unlock via SDK
  Result := False;
end;

end;

{$ENDIF}

