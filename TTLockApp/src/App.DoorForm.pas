unit App.DoorForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  FMX.Forms, FMX.Controls, FMX.Types, FMX.StdCtrls, FMX.Layouts,
  FMX.Controls.Presentation, FMX.Dialogs,
  TTLock.ITTLockService, TTLock.TTLockModels;

type
  TFormDoor = class(TForm)
  private
    ToolBar: TToolBar;
    LabelTitle: TLabel;
    ButtonBack: TButton;
    ButtonOpen: TButton;
    LabelStatus: TLabel;
    FService: ITTLockService;
    FDevice: TTTLockDevice;
    procedure SetupUI;
    procedure ButtonBackClick(Sender: TObject);
    procedure ButtonOpenClick(Sender: TObject);
  public
    constructor CreateWith(AOwner: TComponent; const Service: ITTLockService; const Device: TTTLockDevice);
  end;

implementation

constructor TFormDoor.CreateWith(AOwner: TComponent; const Service: ITTLockService; const Device: TTTLockDevice);
begin
  inherited Create(AOwner);
  FService := Service;
  FDevice := Device;
  SetupUI;
end;

procedure TFormDoor.SetupUI;
begin
  Caption := 'Puerta';
  Width := 360;
  Height := 640;

  ToolBar := TToolBar.Create(Self);
  ToolBar.Parent := Self;
  ToolBar.Align := TAlignLayout.Top;

  ButtonBack := TButton.Create(Self);
  ButtonBack.Parent := ToolBar;
  ButtonBack.Text := 'Volver';
  ButtonBack.Align := TAlignLayout.Left;
  ButtonBack.OnClick := ButtonBackClick;

  LabelTitle := TLabel.Create(Self);
  LabelTitle.Parent := ToolBar;
  LabelTitle.Align := TAlignLayout.Contents;
  LabelTitle.TextSettings.HorzAlign := TTextAlign.Center;
  LabelTitle.TextSettings.Font.Size := 18;
  LabelTitle.Text := FDevice.Name;

  ButtonOpen := TButton.Create(Self);
  ButtonOpen.Parent := Self;
  ButtonOpen.Text := 'Abrir';
  ButtonOpen.Align := TAlignLayout.Center;
  ButtonOpen.Margins.Rect := TRectF.Create(40, 40, 40, 40);
  ButtonOpen.Width := 160;
  ButtonOpen.Height := 48;
  ButtonOpen.OnClick := ButtonOpenClick;

  LabelStatus := TLabel.Create(Self);
  LabelStatus.Parent := Self;
  LabelStatus.Align := TAlignLayout.Bottom;
  LabelStatus.Height := 28;
  LabelStatus.TextSettings.HorzAlign := TTextAlign.Center;
  LabelStatus.Text := 'Listo';
end;

procedure TFormDoor.ButtonBackClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFormDoor.ButtonOpenClick(Sender: TObject);
var
  ok: Boolean;
begin
  LabelStatus.Text := 'Abriendo...';
  ok := FService.Unlock(FDevice);
  if ok then
  begin
    ShowMessage('OK');
    ModalResult := mrOk;
  end
  else
  begin
    ShowMessage('Error al abrir');
    ModalResult := mrAbort;
  end;
end;

end.

