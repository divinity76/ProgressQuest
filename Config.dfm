object K: TK
  Left = 457
  Top = 331
  Width = 800
  Height = 567
  Caption = 'K'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 116
    Width = 28
    Height = 13
    Caption = 'Spells'
  end
  object Label2: TLabel
    Left = 168
    Top = 4
    Width = 64
    Height = 13
    Caption = 'Offense Attrib'
  end
  object Label3: TLabel
    Left = 280
    Top = 228
    Width = 70
    Height = 13
    Caption = 'Defense Atrtrib'
  end
  object Label4: TLabel
    Left = 140
    Top = 228
    Width = 34
    Height = 13
    Caption = 'Shields'
  end
  object Label5: TLabel
    Left = 8
    Top = 228
    Width = 27
    Height = 13
    Caption = 'Armor'
  end
  object Label6: TLabel
    Left = 8
    Top = 4
    Width = 41
    Height = 13
    Caption = 'Weapon'
  end
  object Label7: TLabel
    Left = 164
    Top = 428
    Width = 40
    Height = 13
    Caption = 'Speicals'
  end
  object Label8: TLabel
    Left = 8
    Top = 428
    Width = 47
    Height = 13
    Caption = 'Item Attrib'
  end
  object Label9: TLabel
    Left = 320
    Top = 428
    Width = 34
    Height = 13
    Caption = 'Item Of'
  end
  object Label10: TLabel
    Left = 172
    Top = 116
    Width = 58
    Height = 13
    Caption = 'Boring Items'
  end
  object Label11: TLabel
    Left = 12
    Top = 344
    Width = 125
    Height = 13
    Caption = 'Monsters (name level item)'
  end
  object Label12: TLabel
    Left = 236
    Top = 344
    Width = 162
    Height = 13
    Caption = 'Monster mods (adjustment pattern)'
  end
  object Label13: TLabel
    Left = 324
    Top = 8
    Width = 56
    Height = 13
    Caption = 'OffenseBad'
  end
  object Label14: TLabel
    Left = 404
    Top = 232
    Width = 59
    Height = 13
    Caption = 'DefenseBad'
  end
  object Label15: TLabel
    Left = 480
    Top = 8
    Width = 26
    Height = 13
    Caption = 'Race'
  end
  object Label16: TLabel
    Left = 480
    Top = 120
    Width = 25
    Height = 13
    Caption = 'Class'
  end
  object Label17: TLabel
    Left = 328
    Top = 120
    Width = 25
    Height = 13
    Caption = 'Titles'
  end
  object Label18: TLabel
    Left = 476
    Top = 428
    Width = 74
    Height = 13
    Caption = 'Impressive titles'
  end
  object Spells: TMemo
    Left = 8
    Top = 132
    Width = 153
    Height = 89
    Lines.Strings = (
      'Slime Finger'
      'Rabbit Punch'
      'Hastiness'
      'Good Move'
      'Sadness'
      'Seasick'
      'Gyp'
      'Shoelaces'
      'Innoculate'
      'Cone of Annoyance'
      'Magnetic Orb'
      'Invisible Hands'
      'Revolting Cloud'
      'Aqueous Humor'
      'Spectral Miasma'
      'Clever Fellow'
      'Lockjaw'
      'History Lesson'
      'Hydrophobia'
      'Big Sister'
      'Cone of Paste'
      'Mulligan'
      'Nestor'#39's Bright Idea'
      'Holy Batpole'
      'Tumor (Benign)'
      'Braingate'
      'Nonplus'
      'Animate Nightstand'
      'Eye of the Troglodyte'
      'Curse Name'
      'Dropsy'
      'Vitreous Humor'
      'Roger'#39's Grand Illusion'
      'Covet'
      'Astral Miasma'
      'Spectral Oyster'
      'Acrid Hands'
      'Angioplasty'
      'Grognor'#39's Big Day Off'
      'Tumor (Malignant)'
      'Animate Tunic'
      'Ursine Armor'
      'Holy Roller'
      'Tonsilectomy'
      'Curse Family'
      'Infinite Confusion')
    TabOrder = 0
    WordWrap = False
  end
  object OffenseAttrib: TMemo
    Left = 168
    Top = 20
    Width = 141
    Height = 89
    Lines.Strings = (
      'Polished|+1'
      'Serrated|+1'
      'Heavy|+1'
      'Pronged|+2'
      'Steely|+2'
      'Vicious|+3'
      'Venomed|+4'
      'Stabbity|+4'
      'Dancing|+5'
      'Invisible|+6'
      'Vorpal|+7')
    TabOrder = 1
    WordWrap = False
  end
  object DefenseAttrib: TMemo
    Left = 280
    Top = 244
    Width = 113
    Height = 89
    Lines.Strings = (
      'Studded|+1'
      'Banded|+2'
      'Gilded|+2'
      'Festooned|+3'
      'Holy|+4'
      'Cambric|+1'
      'Fine|+4'
      'Impressive|+5'
      'Custom|+3')
    TabOrder = 2
    WordWrap = False
  end
  object Shields: TMemo
    Left = 140
    Top = 244
    Width = 133
    Height = 89
    Lines.Strings = (
      'Parasol|0'
      'Pie Plate|1'
      'Garbage Can Lid|2'
      'Buckler|3'
      'Plexiglass|4'
      'Fender|4'
      'Round Shield|5'
      'Carapace|5'
      'Scutum|6'
      'Propugner|6'
      'Kite Shield|7'
      'Pavise|8'
      'Tower Shield|9'
      'Baroque Shield|11'
      'Aegis|12'
      'Magnetic Field|18')
    TabOrder = 3
    WordWrap = False
  end
  object Armors: TMemo
    Left = 8
    Top = 244
    Width = 129
    Height = 89
    Lines.Strings = (
      'Lace|1'
      'Macrame|2'
      'Burlap|3'
      'Canvas|4'
      'Flannel|5'
      'Chamois|6'
      'Pleathers|7'
      'Leathers|8'
      'Bearskin|9'
      'Ringmail|10'
      'Scale Mail|12'
      'Chainmail|14'
      'Splint Mail|15'
      'Platemail|16'
      'ABS|17'
      'Kevlar|18'
      'Titanium|19'
      'Mithril Mail|20'
      'Diamond Mail|25'
      'Plasma|30')
    TabOrder = 4
    WordWrap = False
  end
  object Weapons: TMemo
    Left = 8
    Top = 20
    Width = 153
    Height = 89
    Lines.Strings = (
      'Stick|0'
      'Broken Bottle|1'
      'Shiv|1'
      'Sprig|1'
      'Oxgoad|1'
      'Eelspear|2'
      'Bowie Knife|2'
      'Claw Hammer|2'
      'Handpeen|2'
      'Andiron|3'
      'Hatchet|3'
      'Tomahawk|3'
      'Hackbarm|3'
      'Crowbar|4'
      'Mace|4'
      'Battleadze|4'
      'Leafmace|5'
      'Shortsword|5'
      'Longiron|5'
      'Poachard|5'
      'Baselard|5'
      'Whinyard|6'
      'Blunderbuss|6'
      'Longsword|6'
      'Crankbow|6'
      'Blibo|7'
      'Broadsword|7'
      'Kreen|7'
      'Morning Star|8'
      'Pole-adze|8'
      'Spontoon|8'
      'Bastard Sword|9'
      'Peen-arm|9'
      'Culverin|10'
      'Lance|10'
      'Halberd|11'
      'Poleax|12'
      'Bandyclef|15')
    TabOrder = 5
    WordWrap = False
  end
  object Specials: TMemo
    Left = 164
    Top = 444
    Width = 149
    Height = 89
    Lines.Strings = (
      'Diadem'
      'Festoon'
      'Gemstone'
      'Phial'
      'Tiara'
      'Scabbard'
      'Arrow'
      'Lens'
      'Lamp'
      'Hymnal'
      'Fleece'
      'Laurel'
      'Brooch'
      'Gimlet'
      'Cobble'
      'Albatross'
      'Brazier'
      'Bandolier'
      'Tome'
      'Garnet'
      'Amethyst'
      'Candelabra'
      'Corset'
      'Sphere'
      'Sceptre'
      'Ankh'
      'Talisman'
      'Orb'
      'Gammel'
      'Ornament'
      'Brocade'
      'Galoon'
      'Bijou'
      'Spangle'
      'Gimcrack'
      'Hood'
      'Vulpeculum')
    TabOrder = 6
    WordWrap = False
  end
  object ItemAttrib: TMemo
    Left = 8
    Top = 444
    Width = 149
    Height = 89
    Lines.Strings = (
      'Golden'
      'Gilded'
      'Spectral'
      'Astral'
      'Garlanded'
      'Precious'
      'Crafted'
      'Dual'
      'Filigreed'
      'Cruciate'
      'Arcane'
      'Blessed'
      'Reverential'
      'Lucky'
      'Enchanted'
      'Gleaming'
      'Grandiose'
      'Sacred'
      'Legendary'
      'Mythic'
      'Crystalline'
      'Austere'
      'Ostentatious'
      'One True'
      'Proverbial'
      'Fearsome'
      'Deadly'
      'Benevolent'
      'Unearthly'
      'Magnificent'
      'Iron'
      'Ormolu'
      'Puissant')
    TabOrder = 7
    WordWrap = False
  end
  object ItemOfs: TMemo
    Left = 320
    Top = 444
    Width = 149
    Height = 89
    Lines.Strings = (
      'Foreboding'
      'Foreshadowing'
      'Nervousness'
      'Happiness'
      'Torpor'
      'Danger'
      'Craft'
      'Silence'
      'Invisibility'
      'Rapidity'
      'Pleasure'
      'Practicality'
      'Hurting'
      'Joy'
      'Petulance'
      'Intrusion'
      'Chaos'
      'Suffering'
      'Extroversion'
      'Frenzy'
      'Solitude'
      'Punctuality'
      'Efficiency'
      'Comfort'
      'Patience'
      'Internment'
      'Incarceration'
      'Misapprehension'
      'Loyalty'
      'Envy'
      'Acrimony'
      'Worry'
      'Fear'
      'Awe'
      'Guile'
      'Prurience'
      'Fortune'
      'Perspicacity'
      'Domination'
      'Submission'
      'Fealty'
      'Hunger'
      'Despair'
      'Cruelty'
      'Grob'
      'Dignard'
      'Ra'
      'the Bone'
      'Diamonique'
      'Electrum'
      'Hydragyrum')
    TabOrder = 8
    WordWrap = False
  end
  object BoringItems: TMemo
    Left = 168
    Top = 132
    Width = 149
    Height = 89
    Lines.Strings = (
      'nail'
      'lunchpail'
      'sock'
      'I.O.U.'
      'cookie'
      'pint'
      'toothpick'
      'writ'
      'newspaper'
      'letter'
      'plank'
      'hat'
      'egg'
      'coin'
      'needle'
      'bucket'
      'ladder'
      'chicken'
      'twig'
      'dirtclod'
      'counterpane'
      'vest'
      'teratoma'
      'bunny'
      'rock'
      'pole'
      'carrot'
      'canoe'
      'inkwell'
      'hoe'
      'bandage'
      'trowel'
      'towel'
      'planter box'
      'anvil'
      'axle'
      'tuppence'
      'casket'
      'nosegay'
      'trinket'
      'credenza'
      'writ')
    TabOrder = 9
    WordWrap = False
  end
  object Monsters: TMemo
    Left = 8
    Top = 360
    Width = 221
    Height = 61
    Lines.Strings = (
      'Anhkheg|6|chitin'
      'Ant|0|antenna'
      'Ape|4|ass'
      'Baluchitherium|14|ear'
      'Beholder|10|eyestalk'
      'Black Pudding|10|saliva'
      'Blink Dog|4|eyelid'
      'Cub Scout|1|neckercheif'
      'Girl Scout|2|cookie'
      'Boy Scout|3|merit badge'
      'Eagle Scout|4|merit badge'
      'Bugbear|3|skin'
      'Bugboar|3|tusk'
      'Boogie|3|slime'
      'Camel|2|hump'
      'Carrion Crawler|3|egg'
      'Catoblepas|6|neck'
      'Centaur|4|rib'
      'Centipede|0|leg'
      'Cockatrice|5|wattle'
      'Couatl|9|wing'
      'Crayfish|0|antenna'
      'Demogorgon|53|tentacle'
      'Jubilex|17|gel'
      'Manes|1|tooth'
      'Orcus|27|wand'
      'Succubus|6|bra'
      'Vrock|8|neck'
      'Hezrou|9|leg'
      'Glabrezu|10|collar'
      'Nalfeshnee|11|tusk'
      'Marilith|7|arm'
      'Balor|8|whip'
      'Yeenoghu|25|flail'
      'Asmodeus|52|leathers'
      'Baalzebul|43|pants'
      'Barbed Devil|8|flame'
      'Bone Devil|9|hook'
      'Dispater|30|matches'
      'Erinyes|6|thong'
      'Geryon|30|cornucopia'
      'Malebranche|5|fork'
      'Ice Devil|11|snow'
      'Lemure|3|blob'
      'Pit Fiend|13|seed'
      'Anklyosaurus|9|tail'
      'Brontosaurus|30|brain'
      'Diplodocus|24|fin'
      'Elasmosaurus|15|neck'
      'Gorgosaurus|13|arm'
      'Iguanadon|6|thumb'
      'Megalosaurus|12|jaw'
      'Monoclonius|8|horn'
      'Pentasaurus|12|head'
      'Stegosaurus|18|plate'
      'Triceratops|16|horn'
      'Tyranosauraus Rex|18|forearm'
      'Djinn|7|lamp'
      'Doppleganger|4|face'
      'Black Dragon|7|*'
      'Plaid Dragon|7|sporrin'
      'Blue Dragon|9|*'
      'Beige Dragon|9|*'
      'Brass Dragon|7|pole'
      'Tin Dragon|8|*'
      'Bronze Dragon|9|medal'
      'Chromatic Dragon|16|scale'
      'Copper Dragon|8|loafer'
      'Gold Dragon|8|filling'
      'Green Dragon|8|*'
      'Platinum Dragon|21|*'
      'Red Dragon|10|cocktail'
      'Silver Dragon|10|*'
      'White Dragon|6|tooth'
      'Dragon Turtle|13|shell'
      'Dryad|2|acorn'
      'Dwarf|1|drawers'
      'Eel|2|sashimi'
      'Efreet|10|cinder'
      'Sand Elemental|8|glass'
      'Bacon Elemental|10|bit'
      'Porn Elemental|12|lube'
      'Cheese Elemental|14|curd'
      'Hair Elemental|16|follicle'
      'Swamp Elf|1|lilypad'
      'Brown Elf|1|tusk'
      'Sea Elf|1|jerkin'
      'Ettin|10|fur'
      'Frog|0|leg'
      'Violet Fungi|3|spore'
      'Gargoyle|4|gravel'
      'Gelatinous Cube|4|jam'
      'Ghast|4|vomit'
      'Ghost|10|*'
      'Ghoul|2|muscle'
      'Humidity Giant|12|drops'
      'Beef Giant|11|steak'
      'Quartz Giant|10|crystal'
      'Porcelain Giant|9|fixture'
      'Rice Giant|8|grain'
      'Cloud Giant|12|condensation'
      'Fire Giant|11|cigarettes'
      'Frost Giant|10|snowman'
      'Hill Giant|8|corpse'
      'Stone Giant|9|hatchling'
      'Storm Giant|15|barometer'
      'Mini Giant|4|pompadour'
      'Gnoll|2|collar'
      'Gnome|1|hat'
      'Goblin|1|ear'
      'Grid Bug|1|carapace'
      'Jellyrock|9|seedling'
      'Beer Golem|15|foam'
      'Oxygen Golem|17|platelet'
      'Cardboard Golem|14|recycling'
      'Rubber Golem|16|ball'
      'Leather Golem|15|fob'
      'Gorgon|8|testicle'
      'Gray Ooze|3|gravy'
      'Green Slime|2|sample'
      'Griffon|7|nest'
      'Banshee|7|larynx'
      'Harpy|3|mascara'
      'Hell Hound|5|tongue'
      'Hippocampus|4|mane'
      'Hippogriff|3|egg'
      'Hobgoblin|1|patella'
      'Homonculus|2|fluid'
      'Hydra|8|gyrum'
      'Imp|2|tail'
      'Invisible Stalker|8|*'
      'Iron Peasant|3|chaff'
      'Jumpskin|3|shin'
      'Kobold|1|penis'
      'Leprechaun|1|wallet'
      'Leucrotta|6|hoof'
      'Lich|11|crown'
      'Lizard Man|2|tail'
      'Lurker|10|sac'
      'Manticore|6|spike'
      'Mastodon|12|tusk'
      'Medusa|6|eye'
      'Multicell|2|dendrite'
      'Pirate|1|booty'
      'Berserker|1|shirt'
      'Caveman|2|club'
      'Dervish|1|robe'
      'Merman|1|trident'
      'Mermaid|1|gills'
      'Mimic|9|hinge'
      'Mind Flayer|8|tentacle'
      'Minotaur|6|map'
      'Yellow Mold|1|spore'
      'Morkoth|7|teeth'
      'Mummy|6|gauze'
      'Naga|9|rattle'
      'Nebbish|1|belly'
      'Neo-Otyugh|11|organ '
      'Nixie|1|webbing'
      'Nymph|3|hanky'
      'Ochre Jelly|6|nucleus'
      'Octopus|2|beak'
      'Ogre|4|talon'
      'Ogre Mage|5|apparel'
      'Orc|1|snout'
      'Otyugh|7|organ'
      'Owlbear|5|feather'
      'Pegasus|4|aileron'
      'Peryton|4|antler'
      'Piercer|3|tip'
      'Pixie|1|dust'
      'Man-o-war|3|tentacle'
      'Purple Worm|15|dung'
      'Quasit|3|tail'
      'Rakshasa|7|pajamas'
      'Rat|0|tail'
      'Remorhaz|11|protrusion'
      'Roc|18|wing'
      'Roper|11|twine'
      'Rot Grub|1|eggsac'
      'Rust Monster|5|shavings'
      'Satyr|5|hoof'
      'Sea Hag|3|wart'
      'Silkie|3|fur'
      'Shadow|3|silhouette'
      'Shambling Mound|10|mulch'
      'Shedu|9|hoof'
      'Shrieker|3|stalk'
      'Skeleton|1|clavicle'
      'Spectre|7|vestige'
      'Sphinx|10|paw'
      'Spider|0|web'
      'Sprite|1|can'
      'Stirge|1|proboscis'
      'Stun Bear|5|tooth'
      'Stun Worm|2|trode'
      'Su-monster|5|tail'
      'Sylph|3|thigh'
      'Titan|20|sandal'
      'Trapper|12|shag'
      'Treant|10|acorn'
      'Triton|3|scale'
      'Troglodyte|2|tail'
      'Troll|6|hide'
      'Umber Hulk|8|claw'
      'Unicorn|4|blood'
      'Vampire|8|pancreas'
      'Wight|4|lung'
      'Will-o-the-Wisp|9|wisp'
      'Wraith|5|finger'
      'Wyvern|7|wing'
      'Xorn|7|jaw'
      'Yeti|4|fur'
      'Zombie|2|forehead'
      'Wasp|0|stinger'
      'Rat|1|tail'
      'Bunny|0|ear'
      'Moth|0|dust'
      'Beagle|0|collar'
      'Midge|0|corpse'
      'Ostrich|1|beak'
      'Billy Goat|1|beard'
      'Bat|1|wing'
      'Koala|2|heart'
      'Wolf|2|paw'
      'Whippet|2|collar'
      'Uruk|2|boot'
      'Poroid|4|node'
      'Moakum|8|frenum'
      'Fly|0|*'
      'Hogbird|3|curl')
    TabOrder = 10
    WordWrap = False
  end
  object MonMods: TMemo
    Left = 232
    Top = 360
    Width = 221
    Height = 61
    Lines.Strings = (
      '-4 f'#339'tal *'
      '-4 dying *'
      '-3 crippled *'
      '-3 baby *'
      '-2 adolescent'
      '-2 very sick *'
      '-1 lesser *'
      '-1 undernourished *'
      '+1 greater *'
      '+1 * Elder'
      '+2 war *'
      '+2 Battle-*'
      '+3 Were-*'
      '+3 undead *'
      '+4 giant *'
      '+4 * Rex')
    TabOrder = 11
    WordWrap = False
  end
  object OffenseBad: TMemo
    Left = 316
    Top = 20
    Width = 141
    Height = 89
    Lines.Strings = (
      'Dull|-2'
      'Tarnished|-1'
      'Rusty|-3'
      'Padded|-5'
      'Bent|-4'
      'Mini|-4'
      'Rubber|-6'
      'Nerf|-7'
      'Unbalanced|-2')
    TabOrder = 12
    WordWrap = False
  end
  object DefenseBad: TMemo
    Left = 396
    Top = 244
    Width = 141
    Height = 89
    Lines.Strings = (
      'Holey|-1'
      'Patched|-1'
      'Threadbare|-2'
      'Faded|-1'
      'Rusty|-3'
      'Motheaten|-3'
      'Mildewed|-2'
      'Torn|-3'
      'Dented|-3'
      'Cursed|-5'
      'Plastic|-4'
      'Cracked|-4'
      'Warped|-3'
      'Corroded|-3')
    TabOrder = 13
    WordWrap = False
  end
  object Races: TMemo
    Left = 480
    Top = 24
    Width = 249
    Height = 89
    Lines.Strings = (
      'Half Orc|HP Max'
      'Half Man|CHA'
      'Half Halfling|DEX'
      'Double Hobbit|STR'
      'Hob-Hobbit|DEX,CON'
      'Low Elf|CON'
      'Dung Elf|WIS'
      'Talking Pony|MP Max,INT'
      'Gyrognome|DEX'
      'Lesser Dwarf|CON'
      'Crested Dwarf|CHA'
      'Eel Man|DEX'
      'Panda Man|CON,STR'
      'Trans-Kobold|WIS'
      'Enchanted Motorcycle|MP Max'
      'Will o'#39' the Wisp|WIS'
      'Battle-Finch|DEX,INT'
      'Double Wookiee|STR'
      'Skraeling|WIS'
      'Demicanadian|CON'
      'Land Squid|STR,HP Max')
    TabOrder = 14
  end
  object Klasses: TMemo
    Left = 480
    Top = 136
    Width = 249
    Height = 89
    Lines.Strings = (
      'Ur-Paladin|WIS,CON'
      'Voodoo Princess|INT,CHA'
      'Robot Monk|STR'
      'Mu-Fu Monk|DEX'
      'Mage Illusioner|INT,MP Max'
      'Shiv-Knight|DEX'
      'Inner Mason|CON'
      'Fighter/Organist|CHA,STR'
      'Puma Burgular|DEX'
      'Runeloremaster|WIS'
      'Hunter Strangler|DEX,INT'
      'Battle-Felon|STR'
      'Tickle-Mimic|WIS,INT'
      'Slow Poisoner|CON'
      'Bastard Lunatic|CON'
      'Lowling|WIS'
      'Birdrider|WIS'
      'Vermineer|INT')
    TabOrder = 15
  end
  object Titles: TMemo
    Left = 328
    Top = 136
    Width = 57
    Height = 81
    Lines.Strings = (
      'Mr.'
      'Mrs.'
      'Sir'
      'Sgt.'
      'Ms.'
      'Captain'
      'Chief'
      'Admiral'
      'Saint')
    TabOrder = 16
  end
  object ImpressiveTitles: TMemo
    Left = 476
    Top = 442
    Width = 149
    Height = 89
    Lines.Strings = (
      'King'
      'Queen'
      'Lord'
      'Lady'
      'Viceroy'
      'Mayor'
      'Prince'
      'Princess'
      'Chief'
      'Boss'
      'Archbishop')
    TabOrder = 17
    WordWrap = False
  end
end
