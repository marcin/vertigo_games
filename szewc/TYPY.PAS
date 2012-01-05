unit typy;
{ modul typow, stalych i zmiennych, a takze procedur wykorzystywnych }
{ przez moduly i program glowny gry Szewc                            }
{ autor: Marcin Beniamin Stefaniak                                   }
interface
uses crt,dos,graph;
const
  zakres=10;{maksymalna liczba kolumn lub wierszy planszy gry}
  nic=0;{stala dla niezaznaczonej krawedzi na planszy}
  pionowa=1;{stala krawedzi pionowej}
  pozioma=2;{stala krawedzi poziomej}

  {kolory 1-gracza1 2-gracza2 3-lini wczytanych z planszy}
  kolor:array[0..3]of integer=(223,88,39,139);
  bialy=255;
  czarny=0;
  odlx=39;{odleglosc lewej krawedzi planszy od poczatku ekramu}
  odly=35;{odleglosc gornej krawedzi planszy od poczatku ekramu}

  {stale klawiszy:}
  ESC=#27;
  Enter=#13;
  Backspace=#8;
  gora=#72;
  dol=#80;
  lewo=#75;
  prawo=#77;

type
  {typ dla planszy gry}
  TLinia=record
           pol :array[1..2]of byte;
         end;
  TPlansza=array[1..zakres, 1..zakres] of TLinia;

  {typ dla pliku planszy}
  TPair = record
                x,y: integer
             end;
  TFileOfPairs = file of TPair;


  {inforamcja o rozmiarze planszy i o graczach}
  TGracz= record
            m,n:integer;
            info:array[1..2] of record
                                  czlowiek:boolean;
                                  nazwa:string;
                                end;
          end;


  {rodzaje rysunkow}
  rodzaj=(mysza,guzikWl,guzikWyl,Glowa,Monitor,UndoWl,UndoWyl,redowl,redowyl,ramka);

  {dane o rysunkach}
  TDane=array[rodzaj] of record
                           x1,y1,x2,y2:integer;{polozenie rysunku}
                           k1,k2 :integer;{zakres kolorow ktorych nie }
                                          {bedzie wstawial            }
                           p:pointer {miejsce rysunku w pamieci}
                         end;

  {okna opcji}
  ROkna=(gr1,gr2,      {gracze - czlowiek komputer}
         naz1,naz2,    {nazwy graczy}
         undo,redo,    {przyciski undo i redo}
         g1,g2,g3,g4   {guziki od gory g1-wczytanie g2-zapisanie
                       {g3-nowa gra g4-koiec gry});

  {wspolrzedne oknien opcji}
  TOkna=array[ROkna] of record x1,y1,x2,y2 :integer end;


  {typ danych przechowywanych na stosie - inforamcje o ruchach}
  TDaneStos=record
          x,y,k,kto:integer;
        end;

  {typy dla stosu undo i redo}
  TStos=^ElStosu;
  ElStosu= record
              dane:TDaneStos;
              poprz:TStos;
           end;

const
  zak=6;{dlugosc krzyzykow na planszy}

  { stale okreslajace polozenie rysunkow na eranie (x1,y1,x2,y2)   }
  { i zakres kolorow ktory jest tlem i ktorych nie bedzie wstawiac }
  { procedura WstawRys                                             }
  dane:TDane=
  (
    {mysza:}( x1:24;y1:69; x2:38; y2:89; k1:63; k2:78 ),

    {guzik wyl}( x1:198; y1:12; x2:213; y2:25+5; k1:255; k2:255 ) ,

    {guzik wl}( x1:198; y1:36; x2:213; y2:49+5; k1:255; k2:255  ),

    {glowa}(x1:2; y1:3; x2:17; y2:20; k1:255; k2:255),
    {miitor} (x1:0; y1:23; x2:16; y2:40; k1:255; k2:255),

    {undowl}(x1:248-1-1-1; y1:67-2+1; x2:295; y2:105; k1:-1; k2:-1 ),
    {undowyl}(x1:29-0; y1:9;  x2:79; y2:49;  k1:-1; k2:-1 ),

    {redowl}(x1:298-1+1; y1:65+1-1-1; x2:343; y2:108; k1:-1; k2:-1 ),
    {redowyl}(x1:83-1; y1:7; x2:129; y2:49; k1:-1; k2:-1 ),

    {ramka}
    (x1:440; y1:5; x2:630; y2:105; k1:254; k2:254)

  );

  {wspolrzedne okien wyboru opcji}
  okno:TOkna=

  (

   {gr1}(x1:585;y1:32;x2:600;y2:45),
   {gr2}(x1:585;y1:155;x2:600;y2:170),

   {naz1}(x1:501;y1:57;x2:600;y2:70),
   {naz2}(x1:501;y1:180;x2:600;y2:195),

   {undo}(x1:502-2-1;y1:289-2;x2:541;y2:321),
   {rdo}(x1:556-6-1-1+2+1;y1:290-5+1+1-1;x2:594;y2:320),
   {g1}(x1:493;y1:345;x2:504;y2:359),
   {g2}(x1:493;y1:369;x2:505;y2:383),
   {g3}(x1:493;y1:393;x2:505;y2:408),
   {g4}(x1:493;y1:417;x2:504;y2:430)
  );

var
  rodzaje:Rodzaj;
  n,m:integer;{wysokosc i szerokosc planszy}
  dlx,dly:integer;{dlugosc krawedzi pionowych i poziomych}
  nazwaPliku:string;{nazwa pliku planszy}
  gracze:TGracz; {configuracja graczy- nazwy , kto (czlowie i komputer) oraz}
                 { szerokosc i wysokosc planszy}


  {zmienne stosowe dla undo i redo}
  SUndo,SRedo:Tstos;
  DUndo:TDaneStos;

procedure StartCzas;
{ procedura ustala aktualny czas ustalajac zmienne globalne wg,wm,ws,wss    }
{ ktore wykorzysuje funkcja DajCzas do okreslenia czasu pomiedzy wywolaniem }
{ StartCzas a DajCzas                                                       }

function DajCzas:longint;
{ okresla czas od wywolania procedury StartCzas, korzystajac ze zmiennych }
{ wg, wm, ws, wss - czas jest w setnych sekundy                           }

procedure initStos(var s:TStos);
{procedura inicjujaca stos "s"}

procedure Dodaj(var s:TStos;x:TDaneStos);
{dodanie elementu "x" na stos "s"}

procedure pobierz(var s:TStos;var x:TDaneStos);
{pobranie elementu "x" ze stosu "s"}

function pusty(var s:TStos):boolean;
{funkcja zwraca true jesli stos "s" jest pusty, w przeciwnym razie false}

procedure wyczysc(var s:TStos);
{ wyczyszczenie stosu s }

function Tnij(x:integer;zakres:integer):integer;
{ funcja torzaca matroid }

Function kwadrat(var p:TPlansza;i,j:integer):byte;
{ funkcja zwraca ilosc krawedzi przy kwadracie i,j }

function PelnaPlansza(var p:TPlansza):boolean;
{funkcja zwraca true jesli plansza jest cala zapelniona}

function w(x,y,x1,y1,x2,y2:integer):boolean;
{funkcja daje wynik true jesli punkt x,y jest zawarty w prostokacie   }
{o wspolrzednych x1,y1,x2,y2                                          }

implementation

procedure initStos(var s:TStos);
begin
  s:=nil;
end;

function pusty(var s:TStos):boolean;
begin
  pusty:= s=nil;
end;

procedure wyczysc(var s:TStos);
var d:TDaneStos;
begin
  while not pusty(s) do pobierz(s,d);
end;

procedure Dodaj(var s:TStos;x:TDaneStos);
var tmp:TStos;
begin
  tmp:=s;
  New(s);
  s^.dane:=x;
  s^.poprz:=tmp;
end;

procedure pobierz(var s:TStos;var x:TDaneStos);
var tmp:TStos;
begin
  tmp:=s;
  x:=s^.dane;
  s:=tmp^.poprz;
  dispose(tmp);
end;

function w(x,y,x1,y1,x2,y2:integer):boolean;
begin
  w :=  (x>=x1)and(x<=x2)and(y>=y1)and(y<=y2)
end;

function Tnij(x,zakres:integer):integer;
begin
  if x>zakres then x:=1;
  if x<1 then x:=zakres;
  Tnij:=x;
end;

Function kwadrat(var p:TPlansza;i,j:integer):byte;
var k:byte;
begin
  k:=0;
  if p[i,j].pol[Pionowa]<>nic then inc(k);
  if p[i,j].pol[Pozioma]<>nic then inc(k);
  if p[Tnij(i+1,m),j].pol[Pozioma]<>nic then inc(k);
  if p[i,Tnij(j+1,n)].pol[Pionowa]<>nic then inc(k);
  kwadrat:=k;
end;

function PelnaPlansza(var p:TPlansza):boolean;
var
  i,j,k:integer;
  pelna:boolean;
begin
  pelna:=true;
  for i:=1 to m do for j:=1 to n do for k:=1 to 2 do
    if p[i,j].pol[k]=nic then pelna:=false;
  PelnaPlansza:= pelna
end;

var wg,wm,ws,wss:word;

procedure StartCzas;
begin
  gettime(wg,wm,ws,wss);
end;

function DajCzas:longint;
var czas1,czas2:longint;
    g,m,s,ss:longint;
begin
  g:=wg;m:=wm;s:=ws;ss:=wss;
  czas1:=ss+100*s+100*60*m+100*60*60*g;
  gettime(wg,wm,ws,wss);
  g:=wg;m:=wm;s:=ws;ss:=wss;
  czas2:=ss+100*s+100*60*m+100*60*60*g;
  DajCzas:=czas2-czas1;
end;

end.