unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, ImgList;

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
    Label5: TLabel;
    Inventory: TListView;
    Panel4: TPanel;
    Kill: TStatusBar;
    Label6: TLabel;
    ExpBar: TProgressBar;
    KillBar: TProgressBar;
    Timer1: TTimer;
    GoButton: TButton;
    EncumBar: TProgressBar;
    Label7: TLabel;
    Button1: TButton;
    ImageList1: TImageList;
    Button2: TButton;
    procedure GoButtonClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure Task(caption: String; msec: Integer);
    procedure Dequeue;
    procedure Q(s: string);
    function TaskDone: Boolean;
    procedure CompleteQuest;
    procedure M(level: Integer; name, spoor: String);
    procedure CompleteAct;
    procedure RollCharacter;
    procedure S(name: String);
    procedure WinEquip;
    procedure WinSpell;
    procedure WinStat;
    procedure WinItem;
    procedure Aa(var list: TStrings; item: String);
  public
    procedure Put(list: TListView; key: String; value: String); overload;
    procedure Put(list: TListView; pos: Integer; value: String); overload;
    procedure Put(list: TListView; key: String; value: Integer); overload;
    procedure Add(list: TListView; key: String; value: Integer); overload;
    function Get(list: TListView; key: String): String; overload;
    function Get(list: TListView; index: Integer): String; overload;
    function GetI(list: TListView; key: String): Integer; overload;
    function GetI(list: TListView; index: Integer): Integer; overload;
    function Sum(list: TListView): Integer;
  end;

var
  Form1: TForm1;

implementation

uses Unit2, Math;

{$R *.dfm}

const
  MonsterMax = 16;

var
  fMonsters: array[1..MonsterMax] of TStrings;
  fWeapons, fOffenseAttrib, fArmors, fDefenseAttrib, fShields, fSpellList: TStrings;
  fTask: String;
  fQuest: String;
  fQueue: TStrings;

procedure TForm1.Q(s: string);
begin
  if fQueue = nil then fQueue := TStringList.Create;
  fQueue.Add(s);
  Dequeue;
end;

function TForm1.TaskDone: Boolean;
begin
  with KillBar do
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

function PickLow(s: TStrings): String;
begin
  Result := s[Min(Random(s.Count),Random(s.Count))];
end;

function Ends(s,e: String): Boolean;
begin
  Result := Copy(s,1+Length(s)-Length(e),Length(e)) = e;
end;

function Plural(s: String): String;
begin
  if Ends(s,'y')
  then Result := Copy(s,1,Length(s)-1) + 'ies'
  else if Ends(s,'ch')
  then Result := s + 'es'
  else if Ends(s,'f')
  then Result := Copy(s,1,Length(s)-1) + 'ves'
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

function MonsterTask(var level: Integer): String;
var
  qty, lev, i: Integer;
begin
  lev := level;
  for i := 1 to level do begin
    if Odds(2,3) then
      Inc(lev, RandSign());
    if Odds(2,5) then
      Inc(level, RandSign());
  end;
  if lev < 1 then lev := 1;
  if lev > MonsterMax then lev := MonsterMax;
  if level < 1 then level := 1;

  fTask := Pick(fMonsters[lev]);
  Result := Split(fTask,0);
  fTask := 'kill|' + fTask;

  qty := 1;
  case level-lev of
    -3: Result := 'Fœtal ' + Result;
    -2: Result := 'Very Sick ' + Result;
    -1: Result := 'Lesser ' + Result;
    0: ; // that's fine
    1: Result := 'Greater ' + Result;
    2: Result := 'War ' + Result;
    3: Result := 'Über ' + Result;
  else
    if lev = 2 * level
    then Result := 'Half ' + Result
    else if lev * 2 = level
    then Result := 'Double ' + Result
    else begin
      if lev > level then begin
        lev := lev div 2;
        Result := 'Leper ' + Result;
      end;
      qty := (level + (lev div 2)) div 2;
      if qty < 1 then qty := 1;
      level := level * qty;
    end;
  end;

  if qty = 1 then begin
    if Pos(Result[1], 'AEIOUaeiou') > 0
    then Result := 'an ' + Result
    else Result := 'a ' + Result;
  end else begin
    Result := IntToStr(qty) + ' ' + Plural(Result);
  end;
end;

procedure TForm1.Dequeue;
var
  s, a: String;
  n, l: Integer;
begin
  while TaskDone do begin
    if Split(fTask,0) = 'kill' then begin
      if Split(fTask,3) <> '' then
        Add(Inventory,Split(fTask,1) + ' ' + Split(fTask,3),1);
    end else if fTask = 'sell' then with Inventory do begin
      while Items.Count > 1 do begin
        Tag := GetI(Inventory,Items.Count-1);
        Items.Delete(Items.Count-1);
        Add(Inventory,'Gold',Tag);
      end;
    end;
    fTask := '';
    if (fQueue.Count > 0) then begin
      a := Split(fQueue[0],0);
      n := StrToInt(Split(fQueue[0],1));
      s := Split(fQueue[0],2);
      if a = 'task' then begin
        Task(s, n * 1000);
        fQueue.Delete(0);
      end else begin
        raise Exception.Create('bah!');
      end;
    end else with Encumbar do if Position >= Max then begin
      Task('Heading to market to sell loot',4 * 1000);
      fTask := 'sell';
    end else begin
      n := GetI(Traits,'Level');
      l := n;
      s := MonsterTask(n);
      n := (2 * Form2.GameStyle.Position * n * 1000) div l;
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
  end;
end;

procedure TForm1.Put(list: TListView; key, value: String);
begin
  Put(list, IndexOf(list,key), value);
end;

procedure TForm1.Put(list: TListView; key: String; value: Integer);
begin
  Put(list,key,IntToStr(value));
  if key = 'CON' then
    Encumbar.Max := value;
  if list = Inventory then
    Encumbar.Position := Sum(Inventory) - GetI(Inventory,'Gold');
end;

procedure TForm1.Put(list: TListView; pos: Integer; value: String);
begin
  with list.Items.Item[pos] do begin
    if SubItems.Count < 1
    then SubItems.Add(value)
    else SubItems[0] := value;
  end;
end;

procedure TForm1.GoButtonClick(Sender: TObject);
begin
  with ExpBar do begin
    Position := 0;
    Max := 20 * 60; // 20 minutes for level 1...
  end;

  Task('Loading...',1000);
  Q('task|10|Experiencing an enigmatic and foreboding night vision');
  Q('task|6|Much is revealed about that wise old bastard you''d underestimated');
  Q('task|6|A shocking series of events leaves you alone and bewildered, but resolute');
  Q('task|4|Drawing upon an unexpected reserve of determination, you set out on a long and dangerous journey');
  Q('task|1|Loading...');

  PlotBar.Max := 27;
  with Plots.Items.Add do begin
    Caption := 'Prologue';
    StateIndex := 0;
  end;

  Timer1.Enabled := True;
end;

procedure TForm1.WinSpell;
begin
  Add(Spells,PickLow(fSpellList),1);
end;

procedure TForm1.WinEquip;
var
  pos, qual, plus, attrib, attribmax: Integer;
  name: String;
  stuff, better: TStrings;
begin
  qual := Max(Random(GetI(Traits,'Level')),Random(1+GetI(Traits,'Level')));
  pos := Random(Equips.Items.Count);
  case pos of
    0: begin stuff := fWeapons; better := fOffenseAttrib; end;
    1: begin stuff := fShields; better := fDefenseAttrib; end;
  else begin stuff := fArmors; better := fDefenseAttrib; end;
  end;
  if qual > stuff.Count - 1 then
    qual := stuff.Count - 1;
  name := stuff[qual];
  plus := GetI(Traits,'Level') - qual;
  attribmax := Min(plus, better.Count);
  while (plus > 0) and (attribmax >= 0) and Odds(1,2) do begin
    attrib := Random(attribmax+1);
    name := better[attrib] + ' ' + name;
    Dec(plus, attrib);
    attribmax := Max(plus, attrib - 1);
  end;
  if plus <> 0 then name := IntToStr(plus) + ' ' + name;
  if plus > 0 then name := '+' + name;

  Put(Equips, pos, name);
end;

procedure TForm1.WinStat;
begin
  Add(Stats, Stats.Items[Random(Stats.Items.Count)].Caption, 1);
end;

procedure TForm1.WinItem;
begin
  Add(Inventory, 'Special Item', 1);
end;

procedure TForm1.CompleteQuest;
var
  lev, i: Integer;
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
    lev := GetI(Traits,'Level');
    for i := lev downto 1 do
      if Odds(1,3) then
        Inc(lev,RandSign());
    if lev > MonsterMax then lev := MonsterMax - Random(2);
    if lev < 1 then lev := 1;
    with Items.Add do begin
      fQuest := Pick(fMonsters[lev]);
      Caption := 'Exterminate ' + Plural(Split(fQuest,0));
      StateIndex := 0;
      MakeVisible(false);
    end;
    Width := Width - 1; // trigger a column resize
  end;
end;

function Rome(var n: Integer; dn: Integer; var s: String; ds: String): Boolean;
begin
  Result := (n >= dn);
  if Result then begin
    n := n - dn;
    s := s + ds;
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

procedure TForm1.CompleteAct;
begin
  PlotBar.Position := 0;
  with Plots do begin
    Items[Items.Count-1].StateIndex := 1;
    PlotBar.Max := 60 * 60 * (10 + 5 * Items.Count); // 10 hrs + 5/act
    Items.Add.Caption := 'Act ' + IntToRoman(Items.Count);
  end;
end;

procedure TForm1.Task(caption: String; msec: Integer);
begin
  Kill.SimpleText := caption + '...';
  with KillBar do begin
    Position := 0;
    Max := msec;
  end;
end;

procedure TForm1.Add(list: TListView; key: String; value: Integer);
begin
  Put(list, key, value + GetI(list,key));
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
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  with KillBar do begin
    if Position >= Max then begin
      if Kill.SimpleText = 'Loading...' then Max := 0;

      with ExpBar do if Position >= Max then begin
        Position := 0;
        Max := (Max * 3) div 2;
        Add(Traits,'Level',1);
      end else
        Position := Position + KillBar.Max div 1000;

      if Plots.Items.Count > 1 then
        with QuestBar do if Position >= Max then begin
          CompleteQuest;
        end else if Quests.Items.Count > 0 then
          Position := Position + KillBar.Max div 1000;

      with PlotBar do if Position >= Max
      then CompleteAct
      else Position := Position + KillBar.Max div 1000;

      Dequeue();
    end else with KillBar do
      Position := Position + Integer(Timer1.Interval);
  end;
end;

procedure TForm1.M(level: Integer; name, spoor: String);
begin
  fMonsters[level].Add(name + '|' + IntToStr(level) + '|' + spoor);
end;

procedure TForm1.S(name: String);
begin
  fSpellList.Add(name);
end;

procedure TForm1.Aa(var list: TStrings; item: String);
begin
  if list = nil then
    list := TStringList.Create;
  list.Add(item);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  QuestBar.Position := 0;
  PlotBar.Position := 0;
  KillBar.Position := 0;
  ExpBar.Position := 0;
  Encumbar.Position := 0;
  fSpellList := TStringList.Create;
  for i := 1 to MonsterMax do
    fMonsters[i] := TStringList.Create;
  M(1,'Wasp','Stinger');
  M(1,'Rat','Whiskers');
  M(1,'Bunny','Ear');
  M(1,'Moth','Dust');
  M(1,'Beagle','Collar');
  M(1,'Midge','');
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
  M(8,'Mummy','Chapeu');
  M(9,'Vampire','Pancreas');
  M(10,'Slime','Slime');
  M(11,'Giant','Pants');
  M(12,'Bugbear','Fang');
  M(13,'Owlbear','Tuft');
  M(14,'Basilisk','Gallstone');
  M(15,'Cockatrice','Cock');
  M(16,'Dragon','Scale');

  S('Slime Finger');
  S('Rabbit Punch');
  S('Hastiness');
  S('Good Mood');
  S('Sadness');
  S('Seasick');
  S('Magnetic Orb');
  S('Invisible Hands');
  S('Revolting Cloud');
  S('Aqueous Humor');
  S('Spectral Miasma');
  S('Zymarx''s Wild Illusion');
  S('Clever Fellow I');
  S('Clever Fellow II');
  S('Nestor''s Sweeping Concept');
  S('Holy Batpole');
  S('Braingate');
  S('Eye of the Troglodyte');
  S('Curse Name');
  S('Vitreous Humor');
  S('Roger''s Grand Illusion');
  S('Clomdor''s Plastic Window');
  S('Covet');
  S('Astral Miasma');
  S('Spectral Clamshell');
  S('Acrid Hands');
  S('Animate Tunic');
  S('Ursine Armor');
  S('Holy Roller');
  S('Curse Family');
  S('Infinite Confusion');

  Aa(fShields, 'Pie Plate');
  Aa(fShields, 'Buckler');
  Aa(fShields, 'Tower Shield');

  Aa(fArmors, 'Lace');
  Aa(fArmors, 'Macrame');
  Aa(fArmors, 'Burlap');
  Aa(fArmors, 'Canvas');
  Aa(fArmors, 'Flannel');
  Aa(fArmors, 'Chamois');
  Aa(fArmors, 'Pleathers');
  Aa(fArmors, 'Leathers');
  Aa(fArmors, 'Chainmail');
  Aa(fArmors, 'Platemail');

  Aa(fWeapons, 'Stick');
  Aa(fWeapons, 'Broken Bottle');
  Aa(fWeapons, 'Shiv');
  Aa(fWeapons, 'Bowie Knife');
  Aa(fWeapons, 'Claw Hammer');
  Aa(fWeapons, 'Andiron');
  Aa(fWeapons, 'Hatchet');
  Aa(fWeapons, 'Crowbar');
  Aa(fWeapons, 'Longiron');
  Aa(fWeapons, 'Zip Gun');
  Aa(fWeapons, 'Broadsword');
  Aa(fWeapons, 'Longsword');
  Aa(fWeapons, 'Poleax');
  Aa(fWeapons, 'Bandyclef');

  Aa(fDefenseAttrib, 'Studded');
  Aa(fDefenseAttrib, 'Banded');
  Aa(fDefenseAttrib, 'Gilded');
  Aa(fDefenseAttrib, 'Festooned');
  Aa(fDefenseAttrib, 'Holy');
  Aa(fDefenseAttrib, 'Cambric');
  Aa(fDefenseAttrib, 'Fine');
  Aa(fDefenseAttrib, 'Impressive');

  Aa(fOffenseAttrib, 'Polished');
  Aa(fOffenseAttrib, 'Pronged');
  Aa(fOffenseAttrib, 'Steely');
  Aa(fOffenseAttrib, 'Bloodied');
  Aa(fOffenseAttrib, 'Dancing');
  Aa(fOffenseAttrib, 'Invisible');
  Aa(fOffenseAttrib, 'Vorpal');
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  KillBar.Position := KillBar.Max;
end;

procedure TForm1.RollCharacter;
begin
  if mrOk = Form2.ShowModal then ;
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
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  RollCharacter;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Add(Traits,'Level',1);
end;

end.
