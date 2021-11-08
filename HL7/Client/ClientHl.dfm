object Form12: TForm12
  Left = 0
  Top = 0
  Caption = 'ClientHL7'
  ClientHeight = 191
  ClientWidth = 186
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object CheckBoxConnectDisconnet: TCheckBox
    Left = 24
    Top = 31
    Width = 129
    Height = 17
    Caption = 'Connect / Disconnect'
    TabOrder = 0
    OnClick = CheckBoxConnectDisconnetClick
  end
  object Button1: TButton
    Left = 24
    Top = 64
    Width = 105
    Height = 25
    Caption = 'Send HL7 Message'
    TabOrder = 1
    OnClick = Button1Click
  end
  object OraSession1: TOraSession
    Options.Direct = True
    Username = 'HASTANE'
    Server = 'DESKTOP-047A100:1521/orcl'
    Connected = True
    Left = 72
    Top = 112
    EncryptedPassword = '97FF9EFF8CFF8BFF9EFF91FF9AFF'
  end
  object IdTCPClient1: TIdTCPClient
    ConnectTimeout = 0
    Port = 0
    ReadTimeout = -1
    Left = 24
    Top = 112
  end
end
