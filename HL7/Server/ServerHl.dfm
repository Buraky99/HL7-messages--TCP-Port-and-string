object Form13: TForm13
  Left = 0
  Top = 0
  Caption = 'ServerHL7'
  ClientHeight = 265
  ClientWidth = 660
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object CheckBoxConnectDisconnet: TCheckBox
    Left = 376
    Top = 192
    Width = 121
    Height = 17
    Caption = 'Start/Stop'
    TabOrder = 0
    OnClick = CheckBoxConnectDisconnetClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 644
    Height = 121
    Lines.Strings = (
      'Gelen mesaj')
    TabOrder = 1
  end
  object Button1: TButton
    Left = 376
    Top = 146
    Width = 75
    Height = 25
    Caption = 'Parse'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Memo2: TMemo
    Left = 8
    Top = 148
    Width = 337
    Height = 89
    Lines.Strings = (
      'Parse edilen mesaj')
    TabOrder = 3
  end
  object OraSession1: TOraSession
    Options.Direct = True
    Username = 'HASTANE'
    Server = 'DESKTOP-047A100:1521/orcl'
    Connected = True
    Left = 584
    Top = 144
    EncryptedPassword = '97FF9EFF8CFF8BFF9EFF91FF9AFF'
  end
  object IdTCPServer1: TIdTCPServer
    Bindings = <>
    DefaultPort = 0
    OnExecute = IdTCPServer1Execute
    Left = 536
    Top = 144
  end
end
