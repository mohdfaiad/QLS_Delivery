inherited fFormBill: TfFormBill
  Left = 384
  Top = 214
  ClientHeight = 475
  ClientWidth = 447
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited dxLayout1: TdxLayoutControl
    Width = 447
    Height = 475
    inherited BtnOK: TButton
      Left = 301
      Top = 442
      Caption = #24320#21333
      TabOrder = 13
    end
    inherited BtnExit: TButton
      Left = 371
      Top = 442
      TabOrder = 14
    end
    object ListInfo: TcxMCListBox [2]
      Left = 23
      Top = 36
      Width = 351
      Height = 116
      HeaderSections = <
        item
          Text = #20449#24687#39033
          Width = 74
        end
        item
          AutoSize = True
          Text = #20449#24687#20869#23481
          Width = 273
        end>
      ParentFont = False
      Style.Edges = [bLeft, bTop, bRight, bBottom]
      TabOrder = 0
    end
    object ListBill: TcxListView [3]
      Left = 23
      Top = 315
      Width = 372
      Height = 113
      Columns = <
        item
          Caption = #27700#27877#31867#22411
          Width = 200
        end
        item
          Caption = #25552#36135#36710#36742
          Width = 70
        end
        item
          Caption = #21150#29702#37327'('#21544')'
          Width = 90
        end>
      ParentFont = False
      ReadOnly = True
      RowSelect = True
      SmallImages = FDM.ImageBar
      Style.Edges = [bLeft, bTop, bRight, bBottom]
      TabOrder = 11
      ViewStyle = vsReport
    end
    object EditValue: TcxTextEdit [4]
      Left = 93
      Top = 265
      ParentFont = False
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebsSingle
      TabOrder = 6
      Width = 95
    end
    object EditTruck: TcxTextEdit [5]
      Left = 276
      Top = 157
      ParentFont = False
      Properties.MaxLength = 15
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebsSingle
      TabOrder = 2
      OnExit = EditTruckExit
      OnKeyPress = EditLadingKeyPress
      Width = 116
    end
    object BtnAdd: TButton [6]
      Left = 385
      Top = 240
      Width = 39
      Height = 17
      Caption = #28155#21152
      TabOrder = 5
      OnClick = BtnAddClick
    end
    object BtnDel: TButton [7]
      Left = 385
      Top = 265
      Width = 39
      Height = 18
      Caption = #21024#38500
      TabOrder = 7
      OnClick = BtnDelClick
    end
    object EditLading: TcxComboBox [8]
      Left = 93
      Top = 157
      ParentFont = False
      Properties.DropDownListStyle = lsEditFixedList
      Properties.ItemHeight = 18
      Properties.Items.Strings = (
        '0=0'#12289#33258#25552
        '1=1'#12289#19968#31080#21046
        '2=2'#12289#20004#31080#21046)
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebsSingle
      Style.ButtonStyle = btsHotFlat
      Style.PopupBorderStyle = epbsSingle
      TabOrder = 1
      OnKeyPress = EditLadingKeyPress
      Width = 120
    end
    object chkIfHYprint: TcxCheckBox [9]
      Left = 11
      Top = 442
      Caption = #26159#21542#25171#21360#21270#39564#21333
      ParentFont = False
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebsSingle
      Style.HotTrack = False
      TabOrder = 12
      Transparent = True
      Width = 121
    end
    object EditStock: TcxComboBox [10]
      Left = 93
      Top = 240
      ParentFont = False
      Properties.DropDownListStyle = lsEditFixedList
      Properties.OnChange = EditStockPropertiesChange
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebsSingle
      Style.ButtonStyle = btsHotFlat
      Style.PopupBorderStyle = epbsSingle
      TabOrder = 4
      Width = 283
    end
    object EditJXSTHD: TcxTextEdit [11]
      Left = 93
      Top = 182
      ParentFont = False
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebsSingle
      TabOrder = 3
      Width = 121
    end
    object EditSampleID: TcxComboBox [12]
      Left = 277
      Top = 290
      ParentFont = False
      Properties.DropDownListStyle = lsFixedList
      Properties.OnEditValueChanged = EditSampleIDPropertiesEditValueChanged
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebsSingle
      Style.ButtonStyle = btsHotFlat
      Style.PopupBorderStyle = epbsSingle
      TabOrder = 9
      Width = 103
    end
    object EditCenterID: TcxComboBox [13]
      Left = 93
      Top = 290
      ParentFont = False
      Properties.DropDownListStyle = lsFixedList
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebsSingle
      Style.ButtonStyle = btsHotFlat
      Style.PopupBorderStyle = epbsSingle
      TabOrder = 8
      Width = 121
    end
    object SumSap: TcxLabel [14]
      Left = 385
      Top = 290
      AutoSize = False
      ParentFont = False
      Transparent = True
      Height = 16
      Width = 39
    end
    inherited dxLayout1Group_Root: TdxLayoutGroup
      inherited dxGroup1: TdxLayoutGroup
        object dxLayout1Item3: TdxLayoutItem
          Control = ListInfo
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Group2: TdxLayoutGroup
          CaptionOptions.Visible = False
          ButtonOptions.Buttons = <>
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object dxLayout1Item12: TdxLayoutItem
            CaptionOptions.Text = #25552#36135#26041#24335':'
            Control = EditLading
            ControlOptions.ShowBorder = False
          end
          object dxLayout1Item9: TdxLayoutItem
            AlignHorz = ahClient
            CaptionOptions.Text = #25552#36135#36710#36742':'
            Control = EditTruck
            ControlOptions.ShowBorder = False
          end
        end
        object dxLayout1Item6: TdxLayoutItem
          CaptionOptions.Text = #25552#21333#21495'('#32463'):'
          Control = EditJXSTHD
          ControlOptions.ShowBorder = False
        end
      end
      object dxGroup2: TdxLayoutGroup [1]
        AlignVert = avClient
        CaptionOptions.Text = #25552#21333#26126#32454
        ButtonOptions.Buttons = <>
        object dxLayout1Group5: TdxLayoutGroup
          CaptionOptions.Visible = False
          ButtonOptions.Buttons = <>
          Hidden = True
          ShowBorder = False
          object dxLayout1Group8: TdxLayoutGroup
            CaptionOptions.Visible = False
            ButtonOptions.Buttons = <>
            Hidden = True
            LayoutDirection = ldHorizontal
            ShowBorder = False
            object dxLayout1Item7: TdxLayoutItem
              CaptionOptions.Text = #27700#27877#31867#22411':'
              Control = EditStock
              ControlOptions.ShowBorder = False
            end
            object dxLayout1Item10: TdxLayoutItem
              AlignHorz = ahRight
              Control = BtnAdd
              ControlOptions.ShowBorder = False
            end
          end
          object dxLayout1Group7: TdxLayoutGroup
            CaptionOptions.Visible = False
            ButtonOptions.Buttons = <>
            Hidden = True
            LayoutDirection = ldHorizontal
            ShowBorder = False
            object dxLayout1Item8: TdxLayoutItem
              AlignHorz = ahClient
              CaptionOptions.Text = #21150#29702#21544#25968':'
              Control = EditValue
              ControlOptions.ShowBorder = False
            end
            object dxLayout1Item11: TdxLayoutItem
              AlignHorz = ahRight
              Control = BtnDel
              ControlOptions.ShowBorder = False
            end
          end
        end
        object dxLayout1Group3: TdxLayoutGroup
          CaptionOptions.Visible = False
          ButtonOptions.Buttons = <>
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object dxLayout1Item14: TdxLayoutItem
            CaptionOptions.Text = #29983' '#20135' '#32447':'
            Control = EditCenterID
            ControlOptions.ShowBorder = False
          end
          object dxLayout1Item5: TdxLayoutItem
            CaptionOptions.Text = #35797#26679#32534#21495':'
            Control = EditSampleID
            ControlOptions.ShowBorder = False
          end
          object dxLayout1Item15: TdxLayoutItem
            CaptionOptions.Text = 'cxLabel1'
            CaptionOptions.Visible = False
            Control = SumSap
            ControlOptions.ShowBorder = False
          end
        end
        object dxLayout1Item4: TdxLayoutItem
          AlignVert = avClient
          Control = ListBill
          ControlOptions.ShowBorder = False
        end
      end
      inherited dxLayout1Group1: TdxLayoutGroup
        object dxLayout1Item13: TdxLayoutItem [0]
          Control = chkIfHYprint
          ControlOptions.ShowBorder = False
        end
      end
    end
  end
end
