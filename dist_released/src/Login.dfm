object LoginForm: TLoginForm
  Left = 314
  Top = 162
  Width = 265
  Height = 448
  Caption = 'Progress Quest Login'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 12
    Top = 176
    Width = 237
    Height = 69
    Caption = 'New Users'
    TabOrder = 0
    object Label1: TLabel
      Left = 2
      Top = 15
      Width = 233
      Height = 18
      Align = alTop
      AutoSize = False
      Caption = '  To sign up for a new account, visit'
      Layout = tlBottom
    end
    object Label2: TLabel
      Left = 2
      Top = 33
      Width = 233
      Height = 25
      Cursor = crHandPoint
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'http://progressquest.com/user.php'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clActiveCaption
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      OnClick = Label2Click
    end
  end
  object Login: TButton
    Left = 88
    Top = 388
    Width = 75
    Height = 25
    Caption = 'Login'
    Default = True
    Enabled = False
    TabOrder = 1
    OnClick = LoginClick
  end
  object Button1: TButton
    Left = 172
    Top = 388
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object GroupBox2: TGroupBox
    Left = 12
    Top = 256
    Width = 237
    Height = 121
    Caption = 'Proxy Settings'
    TabOrder = 3
    object Label3: TLabel
      Left = 12
      Top = 20
      Width = 213
      Height = 45
      AutoSize = False
      Caption = 
        'Most people can leave this blank, but if you use a proxy to conn' +
        'ect to the Web, or wish to use a proxy to cheat, enter it here.'
      WordWrap = True
    end
    object LabeledEdit1: TLabeledEdit
      Left = 12
      Top = 84
      Width = 149
      Height = 21
      EditLabel.Width = 31
      EditLabel.Height = 13
      EditLabel.Caption = 'Server'
      LabelPosition = lpAbove
      LabelSpacing = 3
      TabOrder = 0
    end
    object LabeledEdit2: TLabeledEdit
      Left = 164
      Top = 84
      Width = 57
      Height = 21
      EditLabel.Width = 19
      EditLabel.Height = 13
      EditLabel.Caption = 'Port'
      LabelPosition = lpAbove
      LabelSpacing = 3
      TabOrder = 1
    end
  end
  object GroupBox3: TGroupBox
    Left = 12
    Top = 12
    Width = 237
    Height = 157
    Caption = 'Account Info'
    TabOrder = 4
    object Label4: TLabel
      Left = 8
      Top = 20
      Width = 221
      Height = 45
      AutoSize = False
      Caption = 
        'Some realms are open to the public riffraff, but others may requ' +
        'ire a valid account. You can enter default account information h' +
        'ere.'
      WordWrap = True
    end
    object Account: TLabeledEdit
      Left = 8
      Top = 84
      Width = 221
      Height = 21
      EditLabel.Width = 40
      EditLabel.Height = 13
      EditLabel.Caption = 'Account'
      LabelPosition = lpAbove
      LabelSpacing = 3
      TabOrder = 0
      OnChange = AccountChange
    end
    object Password: TLabeledEdit
      Left = 8
      Top = 124
      Width = 221
      Height = 21
      EditLabel.Width = 46
      EditLabel.Height = 13
      EditLabel.Caption = 'Password'
      LabelPosition = lpAbove
      LabelSpacing = 3
      PasswordChar = '*'
      TabOrder = 1
      OnChange = AccountChange
    end
  end
end
