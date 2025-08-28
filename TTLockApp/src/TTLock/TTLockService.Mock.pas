unit TTLock.TTLockService.Mock;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  TTLock.ITTLockService, TTLock.TTLockModels;

type
  TMockTTLockService = class(TInterfacedObject, ITTLockService)
  private
    FOnDeviceFound: TTTLockDeviceFoundEvent;
    FInitialized: Boolean;
    procedure SimulateScan;
  public
    procedure Initialize(const AppId, AppSecret: string);
    procedure SetOnDeviceFound(const Handler: TTTLockDeviceFoundEvent);
    procedure StartScan;
    procedure StopScan;
    function Connect(const Device: TTTLockDevice): Boolean;
    function Unlock(const Device: TTTLockDevice): Boolean;
  end;

implementation

procedure TMockTTLockService.Initialize(const AppId, AppSecret: string);
begin
  FInitialized := True;
end;

procedure TMockTTLockService.SetOnDeviceFound(const Handler: TTTLockDeviceFoundEvent);
begin
  FOnDeviceFound := Handler;
end;

procedure TMockTTLockService.StartScan;
begin
  if not FInitialized then
    raise Exception.Create('Service not initialized');
  SimulateScan;
end;

procedure TMockTTLockService.StopScan;
begin
  // no-op in mock
end;

function TMockTTLockService.Connect(const Device: TTTLockDevice): Boolean;
begin
  Result := True;
end;

function TMockTTLockService.Unlock(const Device: TTTLockDevice): Boolean;
begin
  Result := True;
end;

procedure TMockTTLockService.SimulateScan;
var
  d: TTTLockDevice;
  i: Integer;
begin
  for i := 1 to 3 do
  begin
    if Assigned(FOnDeviceFound) then
    begin
      d.Identifier := Format('MOCK-%d', [i]);
      d.Name := Format('TTLock %d', [i]);
      d.Rssi := -50 - i * 3;
      d.IsConnected := False;
      FOnDeviceFound(d);
    end;
  end;
end;

end.

