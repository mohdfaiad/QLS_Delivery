{*******************************************************************************
  作者: dmzn@163.com 2010-3-9
  描述: 选择客户
*******************************************************************************}
unit UFormGetCustom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UFormNormal, cxGraphics, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, dxLayoutControl, StdCtrls, cxControls,
  ComCtrls, cxListView, cxButtonEdit, cxLabel, cxLookAndFeels,
  cxLookAndFeelPainters, dxLayoutcxEditAdapters;

type
  TfFormGetCustom = class(TfFormNormal)
    EditCustom: TcxComboBox;
    dxLayout1Item4: TdxLayoutItem;
    EditCus: TcxButtonEdit;
    dxLayout1Item5: TdxLayoutItem;
    ListCustom: TcxListView;
    dxLayout1Item6: TdxLayoutItem;
    cxLabel1: TcxLabel;
    dxLayout1Item7: TdxLayoutItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnOKClick(Sender: TObject);
    procedure ListCustomKeyPress(Sender: TObject; var Key: Char);
    procedure EditCIDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure EditCustomPropertiesEditValueChanged(Sender: TObject);
    procedure ListCustomDblClick(Sender: TObject);
  private
    { Private declarations }
    FStatus:Boolean;
    //客户信息状态 False：无 True：有
    FCusID,FCusName: string;
    //客户信息
    FDataAreaID: string;
    //账套
    FContractID: string;
    //合同号
    FModel:string;
    //模式 Y：在线模式 N：离线模式
    procedure InitFormData(const nID: string);
    //初始化数据
    function QueryCustom(const nType: Byte): Boolean;
    //查询客户
    procedure GetResult;
    //获取结果
  public
    { Public declarations }
    class function CreateForm(const nPopedom: string = '';
      const nParam: Pointer = nil): TWinControl; override;
    class function FormID: integer; override;
  end;

implementation

{$R *.dfm}

uses
  IniFiles, ULibFun, UMgrControl, UAdjustForm, UFormCtrl, UFormBase, USysGrid,
  USysDB, USysConst, USysBusiness, UDataModule;

class function TfFormGetCustom.CreateForm(const nPopedom: string;
  const nParam: Pointer): TWinControl;
var nP: PFormCommandParam;
begin
  Result := nil;
  if Assigned(nParam) then
       nP := nParam
  else Exit;

  with TfFormGetCustom.Create(Application) do
  begin
    Caption := '选择客户';
    InitFormData(nP.FParamA);

    nP.FCommand := cCmd_ModalResult;
    nP.FParamA := ShowModal;

    if nP.FParamA = mrOK then
    begin
      nP.FParamB := FCusID;
      nP.FParamC := FCusName;
    end;
    Free;
  end;
end;

class function TfFormGetCustom.FormID: integer;
begin
  Result := cFI_FormGetCustom;
end;

procedure TfFormGetCustom.FormCreate(Sender: TObject);
var nIni,myini: TIniFile;
begin
  nIni := TIniFile.Create(gPath + sFormConfig);
  try
    LoadFormConfig(Self, nIni);
    LoadcxListViewConfig(Name, ListCustom, nIni);
  finally
    nIni.Free;
  end;
  myini:=TIniFile.Create('.\Config.Ini');
  try
    FModel:=myini.ReadString('Model','Online','Y');
  finally
    myini.Free;
  end;
end;

procedure TfFormGetCustom.FormClose(Sender: TObject;
  var Action: TCloseAction);
var nIni: TIniFile;
begin
  nIni := TIniFile.Create(gPath + sFormConfig);
  try
    SaveFormConfig(Self, nIni);
    SavecxListViewConfig(Name, ListCustom, nIni);
  finally
    nIni.Free;
  end;

  ReleaseCtrlData(Self);
end;

//------------------------------------------------------------------------------
//Desc: 初始化界面数据
procedure TfFormGetCustom.InitFormData(const nID: string);
var nStr: string;
begin
  if nID <> '' then
  begin
    EditCus.Text := nID;
    if QueryCustom(10) then ActiveControl := ListCustom;
  end;
end;

//Date: 2010-3-9
//Parm: 查询类型(10: 按名称;20: 按人员)
//Desc: 按指定类型查询合同
function TfFormGetCustom.QueryCustom(const nType: Byte): Boolean;
var nStr,nWhere: string;
begin
  Result := False;
  FStatus:=True;
  nWhere := '';
  ListCustom.Items.Clear;

  if nType = 10 then
  begin
    nWhere := 'C_PY Like ''%$ID%'' or C_Name Like ''%$ID%'' or C_ID=''$ID''';
  end else

  if nType = 20 then
  begin
    if (EditCustom.ItemIndex < 1) then Exit;
    //无查询条件

    if EditCustom.ItemIndex > 0 then
      nWhere := nWhere + 'C_ID=''$CID''';
  end;

  nStr := 'Select cus.* From $Cus cus ' ;
  if nWhere <> '' then
    nStr := nStr + ' Where (' + nWhere + ')';
  nStr := nStr + ' Order By C_PY';

  nStr := MacroValue(nStr, [MI('$Cus', sTable_Customer),
          MI('$CID', GetCtrlData(EditCustom)), MI('$ID', EditCus.Text)]);
  //xxxxx

  with FDM.QueryTemp(nStr) do
  if RecordCount > 0 then
  begin
    First;
    while not Eof do
    with ListCustom.Items.Add do
    begin
      Caption := FieldByName('C_ID').AsString;
      SubItems.Add(FieldByName('C_Name').AsString);
      SubItems.Add('-');
      SubItems.Add('*');
      ImageIndex := cItemIconIndex;
      Next;
    end;

    ListCustom.ItemIndex := 0;
    Result := True;
  end else
  begin
    if FModel='Y' then
    begin
      nStr := 'Select * From $ZK zk Where ((Z_Customer Like ''%$ID%'') or (Z_Name Like ''%$ID%'')) ';
      nStr := MacroValue(nStr, [MI('$ZK', sTable_ZhiKa), MI('$ID', EditCus.Text)]);
      with FDM.QueryTemp(nStr) do
      if RecordCount > 0 then
      begin
        FStatus:=False;
        First;
        while not Eof do
        with ListCustom.Items.Add do
        begin
          Caption := FieldByName('Z_Customer').AsString;
          SubItems.Add(FieldByName('Z_Name').AsString);
          if FieldByName('Z_TriangleTrade').AsString='1' then
            SubItems.Add(FieldByName('Z_CompanyId').AsString)
          else
            SubItems.Add(FieldByName('DataAreaID').AsString);
          SubItems.Add(FieldByName('Z_CID').AsString);

          ImageIndex := cItemIconIndex;
          Next;
        end;

        ListCustom.ItemIndex := 0;
        Result := True;
      end;
    end;
  end;
end;

procedure TfFormGetCustom.EditCIDPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  EditCus.Text := Trim(EditCus.Text);
  if (EditCus.Text <> '') and QueryCustom(10) then ListCustom.SetFocus;
end;


procedure TfFormGetCustom.EditCustomPropertiesEditValueChanged(
  Sender: TObject);
begin
  if QueryCustom(20) then ListCustom.SetFocus;
end;

//Desc: 获取结果
procedure TfFormGetCustom.GetResult;
begin
  with ListCustom.Selected do
  begin
    FCusID := Caption;
    FCusName := SubItems[0];
    FDataAreaID := SubItems[1];
    FContractID := SubItems[2];
  end;
end;

procedure TfFormGetCustom.ListCustomKeyPress(Sender: TObject;
  var Key: Char);
var nMsg:string;
begin
  if Key = #13 then
  begin
    Key := #0;
    if ListCustom.ItemIndex > -1 then
    begin
      GetResult;
      if (FModel='Y') and (not FStatus) then
      begin
        if SyncRemoteCustomer(FCusID,FDataAreaID) then
        begin
          nMsg:='客户['+FCusName+']信息下载成功！';
          ShowMsg(nMsg,sHint);
          if GetAXSalesContract(FContractID,FDataAreaID) then
          begin
            nMsg:='['+FContractID+']合同信息下载成功！';
            ShowMsg(nMsg,sHint);
          end else
          begin
            nMsg:='['+FContractID+']合同信息下载失败！';
            ShowMsg(nMsg,sHint);
          end;
        end else
        begin
          nMsg:='客户['+FCusName+']信息下载失败！';
          ShowMsg(nMsg,sHint);
          Exit;
        end;
      end;
      ModalResult := mrOk;
    end;
  end;
end;

procedure TfFormGetCustom.ListCustomDblClick(Sender: TObject);
var nMsg:string;
begin
  if ListCustom.ItemIndex > -1 then
  begin
    GetResult;
    if (FModel='Y') and (not FStatus) then
    begin
      if SyncRemoteCustomer(FCusID,FDataAreaID) then
      begin
        nMsg:='客户['+FCusName+']信息下载成功！';
        ShowMsg(nMsg,sHint);
        if GetAXSalesContract(FContractID,FDataAreaID) then
        begin
          nMsg:='['+FContractID+']合同信息下载成功！';
          ShowMsg(nMsg,sHint);
        end else
        begin
          nMsg:='['+FContractID+']合同信息下载失败！';
          ShowMsg(nMsg,sHint);
        end;
      end else
      begin
        nMsg:='客户['+FCusName+']信息下载失败！';
        ShowMsg(nMsg,sHint);
        Exit;
      end;
    end;
    ModalResult := mrOk;
  end;
end;

procedure TfFormGetCustom.BtnOKClick(Sender: TObject);
var nMsg:string;
begin
  if ListCustom.ItemIndex > -1 then
  begin
    GetResult;
    if (FModel='Y') and (not FStatus) then
    begin
      if SyncRemoteCustomer(FCusID,FDataAreaID) then
      begin
        nMsg:='客户['+FCusName+']信息下载成功！';
        ShowMsg(nMsg,sHint);
        if GetAXSalesContract(FContractID,FDataAreaID) then
        begin
          nMsg:='['+FContractID+']合同信息下载成功！';
          ShowMsg(nMsg,sHint);
        end else
        begin
          nMsg:='['+FContractID+']合同信息下载失败！';
          ShowMsg(nMsg,sHint);
        end;
      end else
      begin
        nMsg:='客户['+FCusName+']信息下载失败！';
        ShowMsg(nMsg,sHint);
        Exit;
      end;
    end;
    ModalResult := mrOk;
  end else ShowMsg('请在查询结果中选择', sHint);
end;

initialization
  gControlManager.RegCtrl(TfFormGetCustom, TfFormGetCustom.FormID);
end.
