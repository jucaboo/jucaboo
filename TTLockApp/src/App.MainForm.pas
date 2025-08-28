unit App.MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListView, FMX.ListView.Types, FMX.Controls.Presentation, FMX.Layouts,
  TTLock.TTLockModels, TTLock.ITTLockService, TTLock.TTLockServiceFactory;

type
  TFormMain = class(TForm)
  private
    ToolBar1: TToolBar;
    LabelTitle: TLabel;
    ButtonScan: TButton;
    ButtonUnlock: TButton;
    ListViewDevices: TListView;
    LabelStatus: TLabel;
    FService: ITTLockService;
    procedure SetupUI;
    procedure HandleDeviceFound(const Device: TTTLockDevice);
    function GetSelectedDevice(out Device: TTTLockDevice): Boolean;
    procedure ButtonScanClick(Sender: TObject);
    procedure ButtonUnlockClick(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  FormMain: TFormMain;

implementation

{ TFormMain }

constructor TFormMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetupUI;
  FService := TTTLockServiceFactory.CreateService;
  FService.SetOnDeviceFound(HandleDeviceFound);
  FService.Initialize('YOUR_TTLOCK_APP_ID', 'YOUR_TTLOCK_APP_SECRET');
end;

procedure TFormMain.SetupUI;
begin
  Caption := 'TTLock Demo';
  Width := 360;
  Height := 640;

  ToolBar1 := TToolBar.Create(Self);
  ToolBar1.Parent := Self;
  ToolBar1.Align := TAlignLayout.Top;

  LabelTitle := TLabel.Create(Self);
  LabelTitle.Parent := ToolBar1;
  LabelTitle.Text := 'TTLock Demo';
  LabelTitle.Align := TAlignLayout.Contents;
  LabelTitle.TextSettings.Font.Size := 18;
  LabelTitle.TextSettings.HorzAlign := TTextAlign.Center;

  ButtonUnlock := TButton.Create(Self);
  ButtonUnlock.Parent := ToolBar1;
  ButtonUnlock.Text := 'Unlock';
  ButtonUnlock.Align := TAlignLayout.Right;
  ButtonUnlock.Margins.Rect := TRectF.Create(4, 4, 4, 4);
  ButtonUnlock.OnClick := ButtonUnlockClick;

  ButtonScan := TButton.Create(Self);
  ButtonScan.Parent := ToolBar1;
  ButtonScan.Text := 'Scan';
  ButtonScan.Align := TAlignLayout.Right;
  ButtonScan.Margins.Rect := TRectF.Create(4, 4, 4, 4);
  ButtonScan.OnClick := ButtonScanClick;

  ListViewDevices := TListView.Create(Self);
  ListViewDevices.Parent := Self;
  ListViewDevices.Align := TAlignLayout.Client;
  ListViewDevices.ItemAppearance := 'ListItem';

  LabelStatus := TLabel.Create(Self);
  LabelStatus.Parent := Self;
  LabelStatus.Align := TAlignLayout.Bottom;
  LabelStatus.Height := 28;
  LabelStatus.Margins.Rect := TRectF.Create(8, 4, 8, 8);
  LabelStatus.Text := 'Idle';
  LabelStatus.TextSettings.HorzAlign := TTextAlign.Center;
end;

procedure TFormMain.ButtonScanClick(Sender: TObject);
begin
  LabelStatus.Text := 'Scanning...';
  ListViewDevices.Items.Clear;
  FService.StartScan;
end;

procedure TFormMain.ButtonUnlockClick(Sender: TObject);
var
  Device: TTTLockDevice;
  ok: Boolean;
begin
  if not GetSelectedDevice(Device) then
  begin
    ShowMessage('Seleccione una cerradura de la lista.');
    Exit;
  end;
  LabelStatus.Text := Format('Unlocking %s...', [Device.Name]);
  ok := FService.Unlock(Device);
  if ok then
    LabelStatus.Text := 'Unlocked'
  else
    LabelStatus.Text := 'Unlock failed';
end;

procedure TFormMain.HandleDeviceFound(const Device: TTTLockDevice);
var
  item: TListViewItem;
begin
  item := ListViewDevices.Items.Add;
  item.Text := Device.Name;
  item.Detail := Format('RSSI: %d  ID: %s', [Device.Rssi, Device.Identifier]);
  item.TagString := Device.Identifier;
end;

function TFormMain.GetSelectedDevice(out Device: TTTLockDevice): Boolean;
var
  item: TListViewItem;
begin
  Result := False;
  if ListViewDevices.Selected = nil then
    Exit;
  item := ListViewDevices.Selected;
  Device.Identifier := item.TagString;
  Device.Name := item.Text;
  Device.Rssi := 0;
  Device.IsConnected := False;
  Result := True;
end;

end.

