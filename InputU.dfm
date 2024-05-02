object inputfrm: Tinputfrm
  Left = 755
  Top = 297
  Cursor = crArrow
  BorderStyle = bsNone
  ClientHeight = 78
  ClientWidth = 288
  Color = clInfoBk
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = Destroy
  OnShow = FormShow
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 537
    Height = 20
    Align = alCustom
    AutoSize = True
    Color = clInfoBk
    TabOrder = 0
    object Button1: TLabel
      Left = 41
      Top = 1
      Width = 36
      Height = 18
      Align = alLeft
      Anchors = [akLeft, akTop, akRight, akBottom]
      BiDiMode = bdLeftToRight
      Caption = #25340' '#38899'   '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      PopupMenu = PopupMenu1
      Layout = tlCenter
      OnClick = Button1Click
      OnMouseMove = StaticText1MouseMove
      ExplicitHeight = 13
    end
    object RzBitBtn1: TLabel
      Left = 1
      Top = 1
      Width = 40
      Height = 18
      Align = alLeft
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = False
      BiDiMode = bdLeftToRight
      Caption = #20116' '#31508'   '
      Color = clOlive
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBiDiMode = False
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      PopupMenu = PopupMenu1
      ShowHint = False
      Transparent = False
      Layout = tlCenter
      OnClick = RzBitBtn1Click
      OnMouseMove = StaticText1MouseMove
    end
    object Button3: TLabel
      Left = 77
      Top = 1
      Width = 36
      Height = 18
      Align = alLeft
      Anchors = [akLeft, akTop, akRight, akBottom]
      BiDiMode = bdLeftToRight
      Caption = #21322' '#35282'   '
      Color = clTeal
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBiDiMode = False
      ParentColor = False
      ParentFont = False
      PopupMenu = PopupMenu1
      Layout = tlCenter
      OnClick = Button3Click
      OnMouseMove = StaticText1MouseMove
      ExplicitHeight = 13
    end
    object RzBitBtn2: TLabel
      Left = 113
      Top = 1
      Width = 36
      Height = 18
      Align = alLeft
      Anchors = [akLeft, akTop, akRight, akBottom]
      BiDiMode = bdLeftToRight
      Caption = #36864' '#20986'   '
      Color = clPurple
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBiDiMode = False
      ParentColor = False
      ParentFont = False
      PopupMenu = PopupMenu1
      Layout = tlCenter
      OnClick = RzBitBtn2Click
      ExplicitHeight = 13
    end
    object StaticText1: TStaticText
      Left = 149
      Top = 1
      Width = 126
      Height = 18
      Align = alLeft
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = '  '#33853#23518#24778#26790'                '
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 0
      OnMouseMove = Button1MouseMove
    end
  end
  object Label1: TMemo
    Left = 0
    Top = 22
    Width = 267
    Height = 51
    BorderStyle = bsNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    OEMConvert = True
    ParentFont = False
    ParentShowHint = False
    PopupMenu = PopupMenu1
    ReadOnly = True
    ShowHint = False
    TabOrder = 1
    WantReturns = False
    WordWrap = False
  end
  object RzBitBtn3: TButton
    Left = 270
    Top = 21
    Width = 17
    Height = 22
    Caption = #8743
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 2
    OnClick = RzBitBtn3Click
  end
  object RzBitBtn4: TButton
    Left = 270
    Top = 43
    Width = 17
    Height = 21
    Caption = #8744
    PopupMenu = PopupMenu1
    TabOrder = 3
    OnClick = RzBitBtn4Click
  end
  object PopupMenu1: TPopupMenu
    Left = 40
    Top = 26
    object menuDefineWord: TMenuItem
      Caption = #28155#21152'/'#21024#38500#23383#35789
      OnClick = menuDefineWordClick
    end
    object menuDefineSymbol: TMenuItem
      Caption = #28155#21152'/'#21024#38500#31526#21495
      OnClick = menuDefineSymbolClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object menuImportLibrary: TMenuItem
      Caption = #23548#20837#23383#35789#24211
      OnClick = menuImportLibraryClick
    end
    object menuExportLibrary: TMenuItem
      Caption = #23548#20986#23383#35789#24211
      OnClick = menuExportLibraryClick
    end
    object menuExportSymbols: TMenuItem
      Caption = #23548#20986#31526#21495#24211
      OnClick = menuExportSymbolsClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object menuText: TMenuItem
      Caption = #27979#35797
      OnClick = menuTextClick
    end
    object menuAbout: TMenuItem
      Caption = #20851#20110
      OnClick = menuAboutClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object menuExit: TMenuItem
      Caption = #36864#20986
      OnClick = menuExitClick
    end
  end
end
