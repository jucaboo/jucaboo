unit TTLock.ITTLockService;

interface

uses
  System.Classes, TTLock.TTLockModels;

type
  TTTLockDeviceFoundEvent = procedure(const Device: TTTLockDevice) of object;

  ITTLockService = interface
    ['{7D2B7C79-61B5-49F1-9B57-5BF7ED3DB06A}']
    procedure Initialize(const AppId, AppSecret: string);
    procedure SetOnDeviceFound(const Handler: TTTLockDeviceFoundEvent);
    procedure StartScan;
    procedure StopScan;
    function Connect(const Device: TTTLockDevice): Boolean;
    function Unlock(const Device: TTTLockDevice): Boolean;
  end;

implementation

end.

