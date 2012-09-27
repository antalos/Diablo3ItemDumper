object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'd3 Item Dumper'
  ClientHeight = 316
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
    316)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 294
    Height = 13
    Caption = 'Press F9 while cursor is over item - the text should be copied '
  end
  object Memo1: TMemo
    Left = 0
    Top = 112
    Width = 313
    Height = 201
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
  object ApplicationEvents1: TApplicationEvents
    OnMinimize = ApplicationEvents1Minimize
    Left = 104
    Top = 56
  end
end
