object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'd3 Item Dumper'
  ClientHeight = 466
  ClientWidth = 315
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    315
    466)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 294
    Height = 13
    Caption = 'Press F9 while cursor is over item - the text should be copied '
  end
  object Label2: TLabel
    Left = 8
    Top = 112
    Width = 72
    Height = 13
    Caption = 'Dump Item key'
  end
  object Label3: TLabel
    Left = 8
    Top = 135
    Width = 73
    Height = 13
    Caption = 'Dump Char key'
  end
  object Label4: TLabel
    Left = 172
    Top = 112
    Width = 62
    Height = 13
    Caption = 'Dump AH res'
  end
  object Memo1: TMemo
    Left = 0
    Top = 160
    Width = 313
    Height = 298
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 27
    Width = 75
    Height = 25
    Caption = 'dump ui'
    TabOrder = 1
    Visible = False
    OnClick = Button1Click
  end
  object cbTranslate: TCheckBox
    Left = 203
    Top = 59
    Width = 110
    Height = 17
    Caption = 'translate RU-> EN'
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
  object hkDumpItem: THotKey
    Left = 86
    Top = 112
    Width = 70
    Height = 19
    HotKey = 32833
    TabOrder = 3
  end
  object Button2: TButton
    Left = 159
    Top = 130
    Width = 75
    Height = 25
    Caption = 'Save keys'
    TabOrder = 4
    OnClick = Button2Click
  end
  object hkDumpChar: THotKey
    Left = 87
    Top = 135
    Width = 70
    Height = 19
    HotKey = 32833
    TabOrder = 5
  end
  object hkDumpAH: THotKey
    Left = 242
    Top = 112
    Width = 70
    Height = 19
    HotKey = 32833
    TabOrder = 6
  end
  object ApplicationEvents1: TApplicationEvents
    OnMinimize = ApplicationEvents1Minimize
    Left = 104
    Top = 56
  end
end
