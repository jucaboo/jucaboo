unit TTLock.TTLockService.iOS;

interface

{$IFDEF IOS}

uses
  System.SysUtils, Macapi.ObjectiveC, iOSapi.Foundation, iOSapi.CocoaTypes,
  iOSapi.CoreBluetooth,
  TTLock.ITTLockService, TTLock.TTLockModels;

type
  TIosTTLockService = class(TInterfacedObject, ITTLockService)
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

procedure TIosTTLockService.Initialize(const AppId, AppSecret: string);
begin
  // TODO: Initialize TTLock iOS SDK with AppId/AppSecret
end;

procedure TIosTTLockService.SetOnDeviceFound(const Handler: TTTLockDeviceFoundEvent);
begin
  FOnDeviceFound := Handler;
end;

procedure TIosTTLockService.StartScan;
begin
  // TODO: use TTLock SDK discover method and map callback to FOnDeviceFound
end;

procedure TIosTTLockService.StopScan;
begin
  // TODO: stop scan
end;

function TIosTTLockService.Connect(const Device: TTTLockDevice): Boolean;
begin
  // TODO: connect using SDK
  Result := False;
end;

function TIosTTLockService.Unlock(const Device: TTTLockDevice): Boolean;
begin
  // TODO: unlock via SDK
  Result := False;
end;

end;

{$ENDIF}

