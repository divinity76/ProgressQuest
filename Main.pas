unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, ImgList, Menus, Psock,
  NMHttp;

const
  RevString = '&rev=2';

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Traits: TListView;
    Equips: TListView;
    Panel3: TPanel;
    Label3: TLabel;
    QuestBar: TProgressBar;
    Stats: TListView;
    Label2: TLabel;
    PlotBar: TProgressBar;
    Plots: TListView;
    Quests: TListView;
    Panel2: TPanel;
    Label4: TLabel;
    Spells: TListView;
    InventoryLabelAlsoGameStyle: TLabel;
    Inventory: TListView;
    Panel4: TPanel;
    Kill: TStatusBar;
    Label6: TLabel;
    ExpBar: TProgressBar;
    TaskBar: TProgressBar;
    Timer1: TTimer;
    EncumBar: TProgressBar;
    Label7: TLabel;
    ImageList1: TImageList;
    Label8: TLabel;
    Cheats: TPanel;
    CashIn: TButton;
    Button1: TButton;
    FinishQuest: TButton;
    Button3: TButton;
    CheatPlot: TButton;
    vars: TPanel;
    fTask: TLabel;
    fQuest: TLabel;
    fQueue: TListBox;
    procedure GoButtonClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CashInClick(Sender: TObject);
    procedure FinishQuestClick(Sender: TObject);
    procedure CheatPlotClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure Task(caption: String; msec: Integer);
    procedure Dequeue;
    procedure Q(s: string);
    function TaskDone: Boolean;
    procedure CompleteQuest;
    procedure CompleteAct;
    function RollCharacter: Boolean;
    procedure WinEquip;
    procedure WinSpell;
    procedure WinStat;
    procedure WinItem;
    function SpecialItem: String;
    procedure LevelUp;
    function BoringItem: String;
    function InterestingItem: String;
    function MonsterTask(var level: Integer): String;
    function EquipPrice: Integer;
    procedure Brag;
    procedure TriggerAutosizes;
  public
    procedure LoadGame(name: String);
    function SaveGame(report: Boolean): Boolean;
    procedure Put(list: TListView; key: String; value: String); overload;
    procedure Put(list: TListView; pos: Integer; value: String); overload;
    procedure Put(list: TListView; key: String; value: Integer); overload;
    procedure Add(list: TListView; key: String; value: Integer); overload;
    procedure AddR(list: TListView; key: String; value: Integer); overload;
    function Get(list: TListView; key: String): String; overload;
    function Get(list: TListView; index: Integer): String; overload;
    function GetI(list: TListView; key: String): Integer; overload;
    function GetI(list: TListView; index: Integer): Integer; overload;
    function Sum(list: TListView): Integer;
  end;

var
  Form1: TForm1;

function Split(s: String; field: Integer): String;

implementation

uses NewGuy, Math, Config, Front, ShellAPI, zlibex;

{$R *.dfm}

procedure TForm1.Q(s: string);
begin
  fQueue.Items.Add(s);
  Dequeue;
end;

function TForm1.TaskDone: Boolean;
begin
  with TaskBar do
    Result := Position >= Max;
end;

function Odds(chance, outof: Integer): Boolean;
begin
  Result := Random(outof) < chance;
end;

function RandSign(): Integer;
begin
  Result := Random(2) * 2 - 1;
end;

function Pick(s: TStrings): String;
begin
  Result := s[Random(s.Count)];
end;

function RandomLow(below: Integer): Integer;
begin
  Result := Min(Random(below),Random(below));
end;
            
function Ends(s,e: String): Boolean;
begin
  Result := Copy(s,1+Length(s)-Length(e),Length(e)) = e;
end;

function Plural(s: String): String;
begin
  if Ends(s,'y')
  then Result := Copy(s,1,Length(s)-1) + 'ies'
  else if Ends(s,'ch') or Ends(s,'x') or Ends(s,'s')
  then Result := s + 'es'
  else if Ends(s,'f')
  then Result := Copy(s,1,Length(s)-1) + 'ves'
  else if Ends(s,'men') or Ends(s,'Men')
  then Result := Copy(s,1,Length(s)-2) + 'en'
  else Result := s + 's';
end;

function Split(s: String; field: Integer): String;
var
  p: Integer;
begin
  while field > 0 do begin
    p := Pos('|',s);
    s := Copy(s,p+1,10000);
    Dec(field);
  end;
  if Pos('|',s) > 0
  then Result := Copy(s,1,Pos('|',s)-1)
  else Result := s;
end;

function Indefinite(s: String; qty: Integer): String;
begin
  if qty = 1 then begin
    if Pos(s[1], 'AEIOUÜaeiouü') > 0
    then Result := 'an ' + s
    else Result := 'a ' + s;
  end else begin
    Result := IntToStr(qty) + ' ' + Plural(s);
  end;
end;

function Definite(s: String; qty: Integer): String;
begin
  if qty > 1 then
    s := {IntToStr(qty) + ' ' +} Plural(s);
  Result := 'the ' + s;
end;

function Sick(m: Integer; s: String): String;
begin
  Result := IntToStr(m) + s; // in case I screw up
  case m of
  -5,5: Result := 'dead ' + s;
  -4,4: Result := 'comatose ' + s;
  -3,3: Result := 'crippled ' + s;
  -2,2: Result := 'sick ' + s;
  -1,1: Result := 'undernourished ' + s;
  end;
end;

function Young(m: Integer; s: String): String;
begin
  Result := IntToStr(m) + s; // in case I screw up
  case -m of
  -5,5: Result := 'fœtal ' + s;
  -4,4: Result := 'baby ' + s;
  -3,3: Result := 'preadolescent ' + s;
  -2,2: Result := 'teenage ' + s;
  -1,1: Result := 'underage ' + s;
  end;
end;

function Big(m: Integer; s: String): String;
begin
  Result := s; // in case I screw up
  case m of
  1,-1: Result := 'greater ' + s;
  2,-2: Result := 'massive ' + s;
  3,-3: Result := 'enormous ' + s;
  4,-4: Result := 'giant ' + s;
  5,-5: Result := 'titanic ' + s;
  end;
end;

function Special(m: Integer; s: String): String;
begin
  Result := s; // in case I screw up
  case -m of
  1,-1:
      if Pos(' ',Result) > 0
      then Result := 'veteran ' + s
      else Result := 'Battle-' + s;
  2,-2: Result := 'cursed ' + s;
  3,-3:
      if Pos(' ',Result) > 0
      then Result := 'warrior ' + s
      else Result := 'Were-' + s;
  4,-4: Result := 'undead ' + s;
  5,-5: Result := 'demon ' + s;
  end;
end;

function TForm1.MonsterTask(var level: Integer): String;
var
  qty, lev, i: Integer;
  monster, m1: string;
begin
  for i := level downto 1 do begin
    if Odds(2,5) then
      Inc(level, RandSign());
  end;
  if level < 1 then level := 1;
  // level = level of puissance of opponent(s) we'll return

  if Odds(1,25) then begin
    // use an NPC every once in a while
    monster := 'passing ' + Pick(Form2.Race.Items) + ' ' + Pick(Form2.Klass.Items);
    lev := level;
    monster := monster + '|' + IntToStr(level) + '|*';
  end else if (fQuest.Caption <> '') and Odds(1,4) then begin
    // use the quest monster
    monster := k.Monsters.Lines[fQuest.Tag];
    lev := StrToInt(Split(monster,1));
  end else begin
    // pick the monster out of so many random ones closest to the level we want
    monster := Pick(K.Monsters.Lines);
    lev := StrToInt(Split(monster,1));
    i := 5;
    while (i > 0) do begin // or (lev - level > 4) do begin
      m1 := Pick(K.Monsters.Lines);
      if abs(level-StrToInt(Split(m1,1))) < abs(level-lev) then begin
        monster := m1;
        lev := StrToInt(Split(monster,1));
      end;
      if i > 0 then Dec(i);
    end;
  end;

  fTask.Caption := monster;
  Result := Split(monster,0);
  fTask.Caption := 'kill|' + fTask.Caption;

  qty := 1;
  if (level-lev) > 10 then begin
      // lev is too low. multiply...
      qty := (level + Random(lev)) div max(lev,1);
      if qty < 1 then qty := 1;
      level := level div qty;
  end;

  if (level - lev) <= -10 then begin
    Result := 'imaginary ' + Result;
  end else if (level-lev) < -5 then begin
    i := 10+(level-lev);
    i := 5-Random(i+1);
    Result := Sick(i,Young((lev-level)-i,Result));
  end else if ((level-lev) < 0) and (Random(2) = 1) then begin
    Result := Sick(level-lev,Result);
  end else if ((level-lev) < 0) then begin
    Result := Young(level-lev,Result);
  end else if (level-lev) >= 10 then begin
    Result := 'messianic ' + Result;
  end else if (level-lev) > 5 then begin
    i := 10-(level-lev);
    i := 5-Random(i+1);
    Result := Big(i,Special((level-lev)-i,Result));
  end else if ((level-lev) > 0) and (Random(2) = 1) then begin
    Result := Big(level-lev,Result);
  end else if ((level-lev) > 0) then begin
    Result := Special(level-lev,Result);
  end;

  lev := level;
  level := lev * qty;

  Result := Indefinite(Result, qty);
end;

function ProperCase(s:String):String;
begin
  Result := UpperCase(Copy(s,1,1)) + Copy(s,2,10000);
end;

function TForm1.EquipPrice: Integer;
begin
  Result :=  5 * GetI(Traits,'Level') * GetI(Traits,'Level')
          + 10 * GetI(Traits,'Level')
          + 20;
end;

procedure TForm1.Dequeue;
var
  s, a, old: String;
  n, l: Integer;
begin
  while TaskDone do begin
    if Split(fTask.Caption,0) = 'kill' then begin
      if Split(fTask.Caption,3) = '*' then begin
        WinItem;
      end else if Split(fTask.Caption,3) <> '' then begin
        Add(Inventory,LowerCase(Split(fTask.Caption,1) + ' ' + ProperCase(Split(fTask.Caption,3))),1);
      end;
    end else if fTask.Caption = 'buying' then begin
      // buy some equipment
      Add(Inventory,'Gold',-EquipPrice);
      WinEquip;
    end else if (fTask.Caption = 'market') or (fTask.Caption = 'sell') then with Inventory do begin
      if fTask.Caption = 'sell' then begin
        Tag := GetI(Inventory,1);
        Tag := Tag * GetI(Traits,'Level');
        if Pos(' of ',Items[1].Caption) > 0 then
          Tag := Tag * (1+RandomLow(10)) * (1+RandomLow(GetI(Traits,'Level')));
        Items[0].MakeVisible(false);
        Items.Delete(1);
        Add(Inventory,'Gold',Tag);
      end;
      if Items.Count > 1 then begin
        Task('Selling ' + Indefinite(Inventory.Items[1].Caption, GetI(Inventory,1)), 1 * 1000);
        fTask.Caption := 'sell';
        break;
      end;
    end;
    old := fTask.Caption;
    fTask.Caption := '';
    if (fQueue.Items.Count > 0) then begin
      a := Split(fQueue.Items[0],0);
      n := StrToInt(Split(fQueue.Items[0],1));
      s := Split(fQueue.Items[0],2);
      if a = 'task' then begin
        Task(s, n * 1000);
        fQueue.Items.Delete(0);
      end else begin
        raise Exception.Create('bah!');
      end;
    end else with Encumbar do if Position >= Max then begin
      Task('Heading to market to sell loot',4 * 1000);
      fTask.Caption := 'market';
    end else if (Pos('kill|',old) <= 0) and (old <> 'heading') then begin
      if GetI(Inventory, 'Gold') > EquipPrice then begin
        Task('Negotiating purchase of better equipment', 5 * 1000);
        fTask.Caption := 'buying';
      end else begin
        Task('Heading to the killing fields', 4 * 1000);
        fTask.Caption := 'heading';
      end;
    end else begin
      n := GetI(Traits,'Level');
      l := n;
      s := MonsterTask(n);
      n := (2 * InventoryLabelAlsoGameStyle.Tag * n * 1000) div l;
      Task('Executing ' + s, n);
    end;
  end;
end;

function IndexOf(list: TListView; key: String): Integer;
var
  i: Integer;
begin
  for i := 0 to list.Items.Count-1 do    if list.Items.Item[i].Caption = key then begin
      Result := i;
      Exit;
    end;
  with list.Items.Add do begin
    Result := Index;
    Caption := key;
    MakeVisible(false);
    list.Width := list.Width - 1; // trigger an autosize
  end;
end;

procedure TForm1.Put(list: TListView; key, value: String);
begin
  Put(list, IndexOf(list,key), value);
end;

procedure TForm1.Put(list: TListView; key: String; value: Integer);
begin
  Put(list,key,IntToStr(value));
  if key = 'STR' then
    Encumbar.Max := 10 + value;
  if list = Inventory then with Encumbar do begin
    Position := Sum(Inventory) - GetI(Inventory,'Gold');
    Hint := IntToStr(Position) + '/' + IntToStr(Max) + ' cubits';
  end;
end;

procedure TForm1.Put(list: TListView; pos: Integer; value: String);
begin
  with list.Items.Item[pos] do begin
    if SubItems.Count < 1
    then SubItems.Add(value)
    else SubItems[0] := value;
  end;
end;

function LevelUpTime(level: Integer): Integer;
begin
  // ~20 minutes for level 1, eventually dominated by exponential
  Result := Round((20.0 + IntPower(1.15,level)) * 60.0);
end;

procedure TForm1.GoButtonClick(Sender: TObject);
begin
  with ExpBar do begin
    Position := 0;
    Max := LevelUpTime(1);
  end;

  fTask.Caption := '';
  fQuest.Caption := '';
  fQueue.Items.Clear;

  Task('Loading.',2000); // that dot is spotted for later...
  Q('task|10|Experiencing an enigmatic and foreboding night vision');
  Q('task|6|Much is revealed about that wise old bastard you''d underestimated');
  Q('task|6|A shocking series of events leaves you alone and bewildered, but resolute');
  Q('task|4|Drawing upon an unexpected reserve of determination, you set out on a long and dangerous journey');
  Q('task|2|Loading');

  PlotBar.Max := 26;
  with Plots.Items.Add do begin
    Caption := 'Prologue';
    StateIndex := 0;
  end;

  Timer1.Enabled := True;
  SaveGame(true);
end;

procedure TForm1.WinSpell;
begin
  AddR(Spells, K.Spells.Lines[RandomLow(Min(GetI(Stats,'WIS')+GetI(Traits,'Level'),
                                            K.Spells.Lines.Count))], 1);
end;
{
procedure TForm1.WinEquip;
var
  pos, qual, plus, attrib, attribmax: Integer;
  name: String;
  stuff, better: TStrings;
begin
  qual := Max(Random(GetI(Traits,'Level')),Random(1+GetI(Traits,'Level')));
  pos := Random(Equips.Items.Count);
  case pos of
    0: begin stuff := K.Weapons.Lines; better := K.OffenseAttrib.Lines; end;
    1: begin stuff := K.Shields.Lines; better := K.DefenseAttrib.Lines; end;
  else begin stuff := K.Armors.Lines; better := K.DefenseAttrib.Lines; end;
  end;
  if qual > stuff.Count - 1 then
    qual := stuff.Count - 1;
  name := stuff[qual];
  plus := GetI(Traits,'Level') - qual;
  attribmax := Min(plus, better.Count-1);
  while (plus > 0) and (attribmax > 0) and Odds(1,2) do begin
    attrib := Random(attribmax+1);
    name := better[attrib] + ' ' + name;
    Dec(plus, attrib);
    attribmax := Min(Min(plus, better.Count-1), attrib-1);
  end;
  if plus <> 0 then name := IntToStr(plus) + ' ' + name;
  if plus > 0 then name := '+' + name;

  Put(Equips, pos, name);
end;
}
function LPick(list: TStrings; goal: Integer): String;
var
  i, best, b1: Integer;
  s: String;
begin
  Result := Pick(list);
  for i := 1 to 5 do begin
    best := StrToInt(Split(Result,1));
    s := Pick(list);
    b1 := StrToInt(Split(s,1));
    if abs(goal-best) > abs(goal-b1) then
      Result := s;
  end;
end;

procedure TForm1.WinEquip;
var
  posn, qual, plus, count: Integer;
  name, modifier: String;
  stuff, better, worse: TStrings;
begin
  posn := Random(Equips.Items.Count);
  Equips.Tag := posn; // remember as the "best item"
  if posn = 0 then begin
    stuff := K.Weapons.Lines;
    better := K.OffenseAttrib.Lines;
    worse := K.OffenseBad.Lines;
  end else begin
    better := K.DefenseAttrib.Lines;
    worse := K.DefenseBad.Lines;
    if posn = 1
    then stuff := K.Shields.Lines
    else stuff := K.Armors.Lines;
  end;
  name := LPick(stuff,GetI(Traits,'Level'));
  qual := StrToInt(Split(name,1));
  name := Split(name,0);
  plus := GetI(Traits,'Level') - qual;
  if plus < 0 then better := worse;
  count := 0;
  while (count < 2) and (plus <> 0) do begin
    modifier := Pick(better);
    qual := StrToInt(Split(modifier, 1));
    modifier := Split(modifier, 0);
    if Pos(modifier, name) > 0 then Break; // no repeats
    if Abs(plus) < Abs(qual) then Break; // too much
    name := modifier + ' ' + name;
    Dec(plus, qual);
    Inc(count);
  end;
  if plus <> 0 then name := IntToStr(plus) + ' ' + name;
  if plus > 0 then name := '+' + name;

  Put(Equips, posn, name);
end;

procedure TForm1.WinStat;
var
  i,t: Integer;
  function Square(x: Integer): Integer; begin Result := x * x; end;
begin
  if Odds(1,2)
  then i := Random(Stats.Items.Count)
  else begin
    // favor the best stat so it will tend to clump
    t := 0;
    for i := 0 to 5 do Inc(t,Square(GetI(Stats,i)));
    t := Random(t);
    i := -1;
    while t >= 0 do begin
      Inc(i);
      Dec(t,Square(GetI(Stats,i)));
    end;
  end;
  Add(Stats, Stats.Items[i].Caption, 1);
end;

function TForm1.SpecialItem: String;
begin
  Result := InterestingItem + ' of ' +
            Pick(K.ItemOfs.Lines);
end;

function TForm1.InterestingItem: String;
begin
  Result := Pick(K.ItemAttrib.Lines) + ' ' +
            Pick(K.Specials.Lines);
end;

function TForm1.BoringItem: String;
begin
  Result := Pick(K.BoringItems.Lines);
end;

procedure TForm1.WinItem;
begin
  Add(Inventory, SpecialItem, 1);
end;

procedure TForm1.CompleteQuest;
var
  lev, level, l, i, montag: Integer;
  m: string;
begin
  with QuestBar do begin
    Position := 0;
    Max := 50 + Random(100);
  end;
  with Quests do begin
    if Items.Count > 0 then begin
      Items[Items.Count-1].StateIndex := 1;
      case Random(4) of
        0: WinSpell;
        1: WinEquip;
        2: WinStat;
        3: WinItem;
      end;
    end;
    while Items.Count > 99 do Items.Delete(0);
    {
    lev := GetI(Traits,'Level');
    for i := lev downto 1 do
      if Odds(1,3) then
        Inc(lev,RandSign());
    if lev > MonsterMax then lev := MonsterMax - Random(2);
    if lev < 1 then lev := 1;
    }
    with Items.Add do begin
      case Random(5) of
        0: begin
          level := GetI(Traits,'Level');
          for i := 1 to 4 do begin
            montag := Random(K.Monsters.Lines.Count);
            m := K.Monsters.Lines[montag];
            l := StrToInt(Split(m,1));
            if (i = 1) or (abs(l - level) < abs(lev - level)) then begin
              lev := l;
              fQuest.Caption := m;
              fQuest.Tag := montag;
            end;
          end;
          Caption := 'Exterminate ' + Definite(Split(fQuest.Caption,0),2);
        end;
        1: begin
          fQuest.Caption := InterestingItem;
          Caption := 'Seek ' + Definite(fQuest.Caption,1);
          fQuest.Caption := '';
        end;
        2: begin
          fQuest.Caption := BoringItem;
          Caption := 'Deliver this ' + fQuest.Caption;
          fQuest.Caption := '';
        end;
        3: begin
          fQuest.Caption := BoringItem;
          Caption := 'Fetch me ' + Indefinite(fQuest.Caption,1);
          fQuest.Caption := '';
        end;
        4: begin
          level := GetI(Traits,'Level');
          for i := 1 to 2 do begin
            montag := Random(K.Monsters.Lines.Count);
            m := K.Monsters.Lines[montag];
            l := StrToInt(Split(m,1));
            if (i = 1) or (abs(l - level) < abs(lev - level)) then begin
              lev := l;
              fQuest.Caption := m;
            end;
          end;
          Caption := 'Placate ' + Definite(Split(fQuest.Caption,0),2);
          fQuest.Caption := '';
        end;
      end;
      StateIndex := 0;
      MakeVisible(false);
    end;
    Width := Width - 1; // trigger a column resize
  end;
  SaveGame(false);
end;

function Rome(var n: Integer; dn: Integer; var s: String; ds: String): Boolean;
begin
  Result := (n >= dn);
  if Result then begin
    n := n - dn;
    s := s + ds;
  end;
end;

function UnRome(var s: String; dn: Integer; var n: Integer; ds: String): Boolean;
begin
  Result := (Copy(s,1,Length(ds)) = ds);
  if Result then begin
    s := Copy(s,Length(ds)+1,10000);
    n := n + dn;
  end;
end;

function IntToRoman(n: Integer): String;
begin
  while Rome(n, 1000, Result, 'M') do ;
  Rome(n, 900, Result, 'CM');
  Rome(n, 500, Result, 'D');
  Rome(n, 400, Result, 'CD');
  while Rome(n, 100, Result, 'C') do ;
  Rome(n, 90, Result, 'XC');
  Rome(n, 50, Result, 'L');
  Rome(n, 40, Result, 'XL');
  while Rome(n, 10, Result, 'X') do ;
  Rome(n, 9, Result, 'IX');
  Rome(n, 5, Result, 'V');
  Rome(n, 4, Result, 'IV');
  while Rome(n, 1, Result, 'I') do ;
end;

function RomanToInt(n: String): Integer;
begin
  Result := 0;
  while UnRome(n, 1000, Result, 'M') do ;
  UnRome(n, 900, Result, 'CM');
  UnRome(n, 500, Result, 'D');
  UnRome(n, 400, Result, 'CD');
  while UnRome(n, 100, Result, 'C') do ;
  UnRome(n, 90, Result, 'XC');
  UnRome(n, 50, Result, 'L');
  UnRome(n, 40, Result, 'XL');
  while UnRome(n, 10, Result, 'X') do ;
  UnRome(n, 9, Result, 'IX');
  UnRome(n, 5, Result, 'V');
  UnRome(n, 4, Result, 'IV');
  while UnRome(n, 1, Result, 'I') do ;
end;

procedure TForm1.CompleteAct;
begin
  PlotBar.Position := 0;
  with Plots do begin
    Items[Items.Count-1].StateIndex := 1;
    PlotBar.Max := 60 * 60 * (1 + 5 * Items.Count); // 1 hr + 5/act
    PlotBar.Hint := 'Cutscene omitted';
    with Items.Add do begin
      Caption := 'Act ' + IntToRoman(Items.Count-1);
      MakeVisible(false);
      StateIndex := 0;
      Width := Width-1;
    end;
  end;
  SaveGame(true);
end;

procedure TForm1.Task(caption: String; msec: Integer);
begin
  Kill.SimpleText := caption + '...';
  with TaskBar do begin
    Position := 0;
    Max := msec;
  end;
end;

procedure TForm1.Add(list: TListView; key: String; value: Integer);
begin
  Put(list, key, value + GetI(list,key));
end;

procedure TForm1.AddR(list: TListView; key: String; value: Integer);
begin
  Put(list, key, IntToRoman(value + RomanToInt(Get(list,key))));
end;

function TForm1.Get(list: TListView; key: String): String;
begin
  Result := Get(list, IndexOf(list,key));
end;

function TForm1.Get(list: TListView; index: Integer): String;
begin
  with list.Items.Item[index] do begin
    if SubItems.Count < 1
    then Result := ''
    else Result := SubItems[0];
  end;
end;

function TForm1.GetI(list: TListView; key: String): Integer;
begin
  Result := StrToIntDef(Get(list,key),0);
end;

function TForm1.GetI(list: TListView; index: Integer): Integer;
begin
  Result := StrToIntDef(Get(list,index),0);
end;

function TForm1.Sum(list: TListView): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to list.Items.Count - 1 do
    Inc(Result, GetI(list,i));
end;

procedure PutLast(list: TListView; value: String);
begin
  if list.Items.Count > 0 then
  with list.Items.Item[list.Items.Count-1] do begin
    if SubItems.Count < 1
    then SubItems.Add(value)
    else SubItems[0] := value;
  end;
  list.Width := list.Width - 1; // trigger an autosize
end;

procedure TForm1.LevelUp;
var
  i: Integer;
begin
  Add(Traits,'Level',1);
  Add(Stats,'HP Max', GetI(Stats,'CON') div 3 + 1 + Random(4));
  Add(Stats,'MP Max', GetI(Stats,'INT') div 3 + 1 + Random(4));
  for i := 1 to 2 do WinStat;
  WinSpell;
  with ExpBar do begin
    Position := 0;
    Max := LevelUpTime(GetI(Traits,'Level'));
  end;
  SaveGame(true);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  gain: Boolean;
begin
  gain := Pos('kill|',fTask.Caption) = 1;
  with TaskBar do begin
    if Position >= Max then begin
      if Kill.SimpleText = 'Loading....' then Max := 0;

      if gain then with ExpBar do if Position >= Max
      then LevelUp
      else Position := Position + TaskBar.Max div 1000;
      with ExpBar do Hint := IntToStr(Max-Position) + ' XP needed for next level'; 

      if gain then if Plots.Items.Count > 1 then with QuestBar do if Position >= Max then begin
          CompleteQuest;
      end else if Quests.Items.Count > 0 then begin
          Position := Position + TaskBar.Max div 1000;
          Hint := IntToStr(100 * Position div Max) + '% complete';
      end;

      with PlotBar do if Position >= Max
      then CompleteAct
      else Position := Position + TaskBar.Max div 1000;

      //Time.Caption := FormatDateTime('h:mm:ss',PlotBar.Position / (24.0 * 60 * 60));
      PlotBar.Hint := FormatDateTime('h:mm:ss" remaining"',(PlotBar.Max-PlotBar.Position) / (24.0 * 60 * 60));

      Dequeue();
    end else with TaskBar do
      Position := Position + Integer(Timer1.Interval);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  QuestBar.Position := 0;
  PlotBar.Position := 0;
  TaskBar.Position := 0;
  ExpBar.Position := 0;
  Encumbar.Position := 0;
  {
  for i := 1 to MonsterMax do
    fMonsters[i] := TStringList.Create;
  M(1,'Wasp','Stinger');
  M(1,'Rat','Tail');
  M(1,'Bunny','Ear');
  M(1,'Moth','Dust');
  M(1,'Beagle','Collar');
  M(1,'Midge','Corpse');
  M(2,'Ostrich','Beak');
  M(2,'Billy Goat','Beard');
  M(2,'Bat','Wing');
  M(2,'Koala','Heart');
  M(3,'Wolf','Paw');
  M(3,'Gnome','Skull');
  M(3,'Kobold','Penis');
  M(3,'Whippet','Collar');
  M(4,'Orc','Shoe');
  M(5,'Uruk','Boot');
  M(6,'Tiger','Stripe');
  M(7,'Lich','Mascara');
  M(8,'Mummy','Chapeau');
  M(9,'Vampire','Pancreas');
  M(10,'Slime','Slime');
  M(11,'Giant','Jumpsuit');
  M(12,'Bugbear','Fang');
  M(13,'Owlbear','Tuft');
  M(14,'Basilisk','Gallstone');
  M(15,'Cockatrice','Cock');
  M(16,'Dragon','Scale');
  }
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  TaskBar.Position := TaskBar.Max;
end;

function TForm1.RollCharacter: Boolean;
var
  f: Integer;
begin
  Result := true;
  repeat
    if mrCancel = Form2.ShowModal then begin
      Result := false;
      Exit;
    end;
    if FileExists(Form2.Name.Text + '.pq') and
          (mrNo = MessageDlg('A saved game with that name already exists. Do you want to overwrite it?', mtWarning, [mbYes,mbNo], 0)) then begin
      // go around again
    end else begin
      f := FileCreate(Form2.Name.Text + '.pq');
      if f = -1 then begin
        ShowMessage('The thought police don''t like that name. Choose a name without \\ / : * ? " < > or | in it.');
      end else begin
        FileClose(f);
        Break;
      end;
    end;
  until false;

  with Form2 do begin
    Put(Traits,'Name',Name.Text);
    Put(Traits,'Race',Race.Items[Race.ItemIndex]);
    Put(Traits,'Class',Klass.Items[Klass.ItemIndex]);
    Put(Traits,'Level',1);
    Put(Stats,'STR',STR.Tag);
    Put(Stats,'CON',CON.Tag);
    Put(Stats,'DEX',DEX.Tag);
    Put(Stats,'INT',INT.Tag);
    Put(Stats,'WIS',WIS.Tag);
    Put(Stats,'CHA',CHA.Tag);
    Put(Stats,'HP Max',Random(8) + CON.Tag div 6);
    Put(Stats,'MP Max',Random(8) + INT.Tag div 6);
    Put(Equips,'Weapon','Sharp Stick');
    Put(Inventory,'Gold',0);
    InventoryLabelAlsoGameStyle.Tag := GameStyle.Position;
    GoButtonClick(Form2);
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if ParamCount >= 1 then begin
    LoadGame(ParamStr(1));
    Form2.Server.OnSuccess := nil;
    Form2.Server.OnFailure := nil;
  end else
  while 1=1 do begin
    case Form3.ShowModal of
    mrOk: begin
        if RollCharacter then
          Break;
      end;
    mrRetry: begin
      // load
        if Form3.OpenDialog1.Execute then begin
          LoadGame(Form3.OpenDialog1.Filename);
          Form2.Server.OnSuccess := nil;
          Form2.Server.OnFailure := nil;
          break;
        end;
      end;
    mrCancel: begin
        Close;
        Break;
      end;
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  LevelUp;
end;

procedure TForm1.CashInClick(Sender: TObject);
begin
  WinEquip;
  WinItem;
  WinSpell;
  WinStat;
  Add(Inventory,'Gold',Random(100));
end;

procedure TForm1.FinishQuestClick(Sender: TObject);
begin
  QuestBar.Position := QuestBar.Max;
  TaskBar.Position := TaskBar.Max;
end;

procedure TForm1.CheatPlotClick(Sender: TObject);
begin
  PlotBar.Position := PlotBar.Max;
  TaskBar.Position := TaskBar.Max;
end;

{
function TForm1.SaveGame(report: Boolean): Boolean;
var
  f: TFileStream;
  i: Integer;
  name: String;
begin
  name := Get(Traits,'Name') + '.pq';
  Result := true;
  try
    f := TFileStream.Create(name, fmCreate);
    for i := 0 to ComponentCount-1 do
      f.WriteComponent(Components[i]);
    f.Free;
  except
    on EfCreateError do Result := false;
  end;
  if report then Brag;
end;

procedure TForm1.LoadGame(name: String);
var
  f: TFileStream;
  i: Integer;
begin
  f := TFileStream.Create(name, fmOpenRead);
  for i := 0 to ComponentCount-1 do begin
    f.ReadComponent(Components[i]);
  end;
  f.Free;
  Timer1.Enabled := True;
  TriggerAutosizes;
end;
}

function TForm1.SaveGame(report: Boolean): Boolean;
var
  f: TFileStream;
  m: TMemoryStream;
  i: Integer;
  name: String;
begin
  name := Get(Traits,'Name') + '.pq';
  Result := true;
  try
    f := TFileStream.Create(name, fmCreate);
  except
    on EfCreateError do begin
      Result := false;
      Exit;
    end;
  end;

  m := TMemoryStream.Create;
  for i := 0 to ComponentCount-1 do
    m.WriteComponent(Components[i]);

  m.Seek(0, soFromBeginning);
  ZCompressStream(m, f);

  m.Free;
  f.Free;
  if report then Brag;
end;

procedure TForm1.LoadGame(name: String);
var
  f: TStream;
  m: TStream;
  i: Integer;
begin
  m := TMemoryStream.Create;
  f := TFileStream.Create(name, fmOpenRead);
  try
    ZDecompressStream(f, m);
    f.Free;
  except
    on EZCompressionError do begin
      // backwards-compatibility
      m.Free;
      m := f;
      f := nil;
    end;
  end;
  m.Seek(0, soFromBeginning);
  for i := 0 to ComponentCount-1 do
    m.ReadComponent(Components[i]);
  m.Free;
  Timer1.Enabled := True;
  TriggerAutosizes;
end;

procedure TForm1.TriggerAutosizes;
begin
  Plots.Width := 100;
  Quests.Width := 100;
  Inventory.Width := 100;
  Equips.Width := 100;
  Spells.Width := 100;
  Traits.Width := 100;
  Stats.Width := 100;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Timer1.Enabled then begin
    Timer1.Enabled := false;
    if SaveGame(false) then
      ShowMessage('Game saved as ' + Get(Traits,'Name') + '.pq');
  end;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (FindWindow('TAppBuilder', nil) > 0) and (ssCtrl in Shift) and (ssShift in Shift) and (Key = ord('C')) then begin
    Cheats.Visible := not Cheats.Visible;
    Traits.Hint := '';  // sorry cheater -- you've been taken offline.
  end;
  if (ssCtrl in Shift) and (Key = ord('B')) then begin
    Brag;
   	ShellExecute(GetDesktopWindow(), 'open', PChar('http://www.progressquest.com/hi.php?name=' + UrlEncode(Get(Traits,'Name'))), nil, '', SW_SHOW);
  end;
  if (ssCtrl in Shift) and (Key = ord('M')) then begin
    Stats.Hint := InputBox('Progress Quest', 'Declare your motto!', Stats.Hint);
    Brag;
   	ShellExecute(GetDesktopWindow(), 'open', PChar('http://www.progressquest.com/hi.php?name=' + UrlEncode(Get(Traits,'Name'))), nil, '', SW_SHOW);
  end;
end;

procedure TForm1.Brag;
var
  url: string;
  best, i: Integer;
const
  flat = 1;
begin
  if Traits.Hint = '' then Exit; // not a online game!
  with Traits do for i := 0 to Items.Count-1 do
    url := url + '&' + LowerCase(Items[i].Caption) + '=' + UrlEncode(Items[i].Subitems[0]);
  url := url + '&item=' + UrlEncode(Get(Equips,Equips.Tag));
  if Equips.Tag > 1 then url := url + '+' + Equips.Items[Equips.Tag].Caption;
  best := 0;
  if Spells.Items.Count > 0 then with Spells do begin
    for i := 1 to Items.Count-1 do
      if (i+flat) * RomanToInt(Get(Spells,i)) >
         (best+flat) * RomanToInt(Get(Spells,best)) then
        best := i;
    url := url + '&spell=' + UrlEncode(Items[best].Caption + ' ' + Get(Spells,best));
  end;
  best := 0;
  for i := 1 to 5 do
    if GetI(Stats,i) > GetI(Stats,best) then best := i;
  url := url + '&stat=' + Stats.Items[best].Caption + '+' + Get(Stats,best);
  url := url + '&plot=' + UrlEncode(Plots.Items[Plots.Items.Count-1].Caption);
  url := url + '&motto=' + UrlEncode(Stats.Hint);
  url := url + '&passkey=' + IntToStr((not GetI(Traits,'Level') * 9831) xor Traits.Tag);
  url := url + RevString;
  Form2.Server.Abort;
  url := 'http://www.progressquest.com/hi.php?cmd=brag' + url;
  try
    //Form2.Server.OnSuccess := Form2.ReportSuccess;
    Form2.Server.Get(url);
  except
    on ESockError do begin
      // 'ats okay.
      Form2.Server.Abort;
    end;
  end;
end;

initialization
  RegisterClasses([TForm1]);
end.

