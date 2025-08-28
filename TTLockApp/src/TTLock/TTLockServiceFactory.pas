unit TTLock.TTLockServiceFactory;

interface

uses
  TTLock.ITTLockService;

type
  TTTLockServiceFactory = class
  public
    class function CreateService: ITTLockService; static;
  end;

implementation

{$IFDEF ANDROID}
uses TTLock.TTLockService.Android;
{$ENDIF}
{$IFDEF IOS}
uses TTLock.TTLockService.iOS;
{$ENDIF}
{$IFNDEF ANDROID}
{$IFNDEF IOS}
uses TTLock.TTLockService.Mock;
{$ENDIF}
{$ENDIF}

class function TTTLockServiceFactory.CreateService: ITTLockService;
begin
  {$IFDEF ANDROID}
  Result := TAndroidTTLockService.Create;
  {$ELSEIF Defined(IOS)}
  Result := TIosTTLockService.Create;
  {$ELSE}
  Result := TMockTTLockService.Create;
  {$ENDIF}
end;

end.

