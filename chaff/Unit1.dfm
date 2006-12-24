object Form1: TForm1
  Left = 219
  Top = 95
  Width = 561
  Height = 538
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Progress Quest VI'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 476
    Align = alLeft
    TabOrder = 0
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 183
      Height = 13
      Align = alTop
      Caption = 'Character Sheet'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 1
      Top = 409
      Width = 183
      Height = 13
      Align = alTop
      Caption = 'Experience'
    end
    object Traits: TListView
      Left = 1
      Top = 14
      Width = 183
      Height = 79
      Align = alTop
      Columns = <
        item
          Caption = 'Trait'
          Width = 60
        end
        item
          AutoSize = True
          Caption = 'Value'
        end>
      ColumnClick = False
      Items.Data = {
        6E0000000400000000000000FFFFFFFFFFFFFFFF0000000000000000044E616D
        6500000000FFFFFFFFFFFFFFFF0000000000000000045261636500000000FFFF
        FFFFFFFFFFFF000000000000000005436C61737300000000FFFFFFFFFFFFFFFF
        0000000000000000054C6576656C}
      ReadOnly = True
      TabOrder = 2
      ViewStyle = vsReport
    end
    object Equips: TListView
      Left = 1
      Top = 229
      Width = 183
      Height = 180
      Align = alTop
      Columns = <
        item
          Caption = 'Position'
          Width = 60
        end
        item
          AutoSize = True
          Caption = 'Equipped'
        end>
      ColumnClick = False
      Items.Data = {
        410100000B00000000000000FFFFFFFFFFFFFFFF000000000000000006576561
        706F6E00000000FFFFFFFFFFFFFFFF000000000000000006536865696C640000
        0000FFFFFFFFFFFFFFFF00000000000000000448656C6D00000000FFFFFFFFFF
        FFFFFF0000000000000000074861756265726B00000000FFFFFFFFFFFFFFFF00
        000000000000000A4272617373616972747300000000FFFFFFFFFFFFFFFF0000
        0000000000000956616D62726163657300000000FFFFFFFFFFFFFFFF00000000
        00000000094761756E746C65747300000000FFFFFFFFFFFFFFFF000000000000
        00000847616D6265736F6E00000000FFFFFFFFFFFFFFFF000000000000000007
        4375697373657300000000FFFFFFFFFFFFFFFF00000000000000000747726561
        76657300000000FFFFFFFFFFFFFFFF000000000000000009536F6C6C65726574
        73}
      TabOrder = 1
      ViewStyle = vsReport
    end
    object Stats: TListView
      Left = 1
      Top = 93
      Width = 183
      Height = 136
      Align = alTop
      Columns = <
        item
          Caption = 'Stat'
          Width = 60
        end
        item
          AutoSize = True
          Caption = 'Value'
        end>
      ColumnClick = False
      Items.Data = {
        CE0000000800000000000000FFFFFFFFFFFFFFFF000000000000000003535452
        00000000FFFFFFFFFFFFFFFF000000000000000003434F4E00000000FFFFFFFF
        FFFFFFFF00000000000000000344455800000000FFFFFFFFFFFFFFFF00000000
        0000000003494E5400000000FFFFFFFFFFFFFFFF000000000000000003574953
        00000000FFFFFFFFFFFFFFFF00000000000000000343484100000000FFFFFFFF
        FFFFFFFF0000000000000000064850204D617800000000FFFFFFFFFFFFFFFF00
        00000000000000064D50204D6178}
      TabOrder = 0
      ViewStyle = vsReport
    end
    object ExpBar: TProgressBar
      Left = 1
      Top = 422
      Width = 183
      Height = 16
      Align = alTop
      Min = 0
      Max = 100
      Position = 50
      Smooth = True
      TabOrder = 3
    end
    object GoButton: TButton
      Left = 52
      Top = 444
      Width = 75
      Height = 25
      Caption = 'Go'
      TabOrder = 4
      OnClick = GoButtonClick
    end
    object Button1: TButton
      Left = 12
      Top = 444
      Width = 25
      Height = 25
      Caption = 'L+1'
      TabOrder = 5
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 148
      Top = 444
      Width = 27
      Height = 25
      Caption = 'Q!'
      TabOrder = 6
      OnClick = SpeedButton1Click
    end
  end
  object Panel3: TPanel
    Left = 370
    Top = 0
    Width = 183
    Height = 476
    Align = alLeft
    TabOrder = 1
    object Label3: TLabel
      Left = 1
      Top = 201
      Width = 181
      Height = 13
      Align = alTop
      Caption = 'Quests'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 1
      Top = 1
      Width = 181
      Height = 13
      Align = alTop
      Caption = 'Plot Development'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object QuestBar: TProgressBar
      Left = 1
      Top = 459
      Width = 181
      Height = 16
      Align = alBottom
      Min = 0
      Max = 0
      Smooth = True
      TabOrder = 0
    end
    object Plots: TListView
      Left = 1
      Top = 14
      Width = 181
      Height = 171
      Align = alTop
      Columns = <
        item
          AutoSize = True
          Caption = 'Act'
        end>
      ColumnClick = False
      IconOptions.Arrangement = iaLeft
      ShowColumnHeaders = False
      StateImages = ImageList1
      TabOrder = 1
      ViewStyle = vsReport
    end
    object PlotBar: TProgressBar
      Left = 1
      Top = 185
      Width = 181
      Height = 16
      Align = alTop
      Min = 0
      Max = 0
      Smooth = True
      TabOrder = 2
    end
    object Quests: TListView
      Left = 1
      Top = 214
      Width = 181
      Height = 245
      Align = alClient
      Columns = <
        item
          AutoSize = True
          Caption = 'Quest'
        end>
      ColumnClick = False
      FlatScrollBars = True
      IconOptions.Arrangement = iaLeft
      ReadOnly = True
      ShowColumnHeaders = False
      StateImages = ImageList1
      TabOrder = 3
      ViewStyle = vsReport
    end
  end
  object Panel2: TPanel
    Left = 185
    Top = 0
    Width = 185
    Height = 476
    Align = alLeft
    TabOrder = 2
    object Label4: TLabel
      Left = 1
      Top = 291
      Width = 183
      Height = 13
      Align = alBottom
      Caption = 'Spell Book'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 1
      Top = 1
      Width = 183
      Height = 13
      Align = alTop
      Caption = 'Inventory'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 1
      Top = 262
      Width = 183
      Height = 13
      Align = alBottom
      Caption = 'Encumberance'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Spells: TListView
      Left = 1
      Top = 304
      Width = 183
      Height = 171
      Align = alBottom
      Columns = <
        item
          AutoSize = True
          Caption = 'Spell'
        end
        item
          Caption = 'Level'
          Width = 40
        end>
      ColumnClick = False
      TabOrder = 0
      ViewStyle = vsReport
    end
    object Inventory: TListView
      Left = 1
      Top = 14
      Width = 183
      Height = 248
      Align = alClient
      Columns = <
        item
          AutoSize = True
          Caption = 'Item'
        end
        item
          Caption = 'Qty'
          Width = 40
        end>
      ColumnClick = False
      TabOrder = 1
      ViewStyle = vsReport
    end
    object EncumBar: TProgressBar
      Left = 1
      Top = 275
      Width = 183
      Height = 16
      Align = alBottom
      Min = 0
      Max = 100
      Position = 50
      Smooth = True
      TabOrder = 2
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 476
    Width = 553
    Height = 35
    Align = alBottom
    Caption = 'Panel4'
    TabOrder = 3
    object Kill: TStatusBar
      Left = 1
      Top = -1
      Width = 551
      Height = 19
      Panels = <
        item
          Width = 50
        end>
      SimplePanel = True
      SimpleText = 'Welcome to Progress Quest!'
    end
    object KillBar: TProgressBar
      Left = 1
      Top = 18
      Width = 551
      Height = 16
      Align = alBottom
      Min = 0
      Max = 100
      Position = 50
      Smooth = True
      Step = 1
      TabOrder = 1
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 40
    Top = 120
  end
  object ImageList1: TImageList
    Height = 12
    Width = 12
    Left = 92
    Top = 52
    Bitmap = {
      494C01010200040004000C000C00FFFFFFFFFF00FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000300000000C00000001001000000000008004
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      28000000300000000C0000000100010000000000600000000000000000000000
      000000000000000000000000FFFFFF0000100100000000007FD7FD0000000000
      7FD77D00000000007FD63D00000000007FD41D00000000007FD48D0000000000
      7FD5C500000000007FD7E500000000007FD7F500000000007FD7FD0000000000
      0010010000000000FFFFFF0000000000}
  end
end
