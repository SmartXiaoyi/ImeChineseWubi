object nounglozefrm: Tnounglozefrm
  Left = 985
  Top = 318
  BorderStyle = bsNone
  ClientHeight = 250
  ClientWidth = 355
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
    Width = 355
    Height = 250
    Align = alClient
    Caption = #33258#36896#31526#21495#28155#21152#19982#21024#38500
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnMouseMove = GroupBox1MouseMove
    object Label1: TLabel
      Left = 7
      Top = 26
      Width = 39
      Height = 13
      Caption = #32534#30721#65306' '
    end
    object Label2: TLabel
      Left = 117
      Top = 26
      Width = 39
      Height = 13
      Caption = #23383#35789#65306' '
    end
    object Label3: TLabel
      Left = 7
      Top = 65
      Width = 108
      Height = 13
      Caption = #30456#21516#32534#30721#23383#35789#26174#31034#65306
    end
    object Label4: TLabel
      Left = 117
      Top = 52
      Width = 63
      Height = 13
      Caption = #25554#20837#20301#32622#65306' '
    end
    object Button1: TButton
      Left = 241
      Top = 228
      Width = 56
      Height = 20
      Caption = #36864#20986
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 39
      Top = 24
      Width = 66
      Height = 21
      TabOrder = 1
      OnKeyUp = Edit1KeyUp
    end
    object Edit2: TEdit
      Left = 150
      Top = 24
      Width = 189
      Height = 21
      TabOrder = 2
    end
    object Memo1: TMemo
      Left = 7
      Top = 85
      Width = 332
      Height = 130
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 3
      OnMouseDown = Memo1MouseDown
    end
    object Button2: TButton
      Left = 7
      Top = 228
      Width = 58
      Height = 20
      Caption = #28155#21152
      TabOrder = 4
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 144
      Top = 228
      Width = 83
      Height = 20
      Caption = #20445#23384#23383#24211'      '
      TabOrder = 5
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 75
      Top = 228
      Width = 54
      Height = 20
      Caption = #21024#38500
      TabOrder = 6
      OnClick = Button4Click
    end
    object Edit3: TEdit
      Left = 182
      Top = 50
      Width = 66
      Height = 21
      TabOrder = 7
      OnKeyUp = Edit3KeyUp
    end
  end
end
