object educefrm: Teducefrm
  Left = 689
  Top = 352
  BorderStyle = bsNone
  ClientHeight = 85
  ClientWidth = 340
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 340
    Height = 85
    Align = alClient
    Caption = #25171#24320#23548#20837#23383#35789#24211#25991#20214':'
    TabOrder = 0
    OnMouseMove = GroupBox1MouseMove
    object Edit1: TEdit
      Left = 7
      Top = 20
      Width = 273
      Height = 21
      TabOrder = 0
    end
    object Button3: TButton
      Left = 208
      Top = 52
      Width = 66
      Height = 20
      Caption = #21462#28040
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = Button3Click
    end
    object Button2: TButton
      Left = 91
      Top = 52
      Width = 94
      Height = 20
      BiDiMode = bdRightToLeftNoAlign
      Caption = #23548#20837#23383#35789#24211'   '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button1: TButton
      Left = 286
      Top = 20
      Width = 40
      Height = 20
      Caption = #25171#24320
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = Button1Click
    end
  end
end
