unit obsluga;
{ modul obslugujacy mysz, grafike SVGA i format graficzny BMP 640x480 }
{ autor: Marcin Beniamin Stefaniak                                    }
interface
uses
  crt,dos,graph,typy;

procedure odczytbmp(nazwa:string);
{ odczyt pliku typu bmp w rozdzielczosci 640x480 przy 256 kolorach }
{ ustawia z BMPPalette                                             }

Procedure sciemnij;
{ sciemnienie palety kolorow                }
{ ustawia SCRPalette                        }

procedure paleta;
{ ustala palete kolorow SCRPalette na podstawie danych zawartych  }
{ w BMPPalette                                                    }

function MouseInit : boolean;
{ inicjacja myszy - true gdy pomyslna, false gdy niepomyslna }

Procedure ZwolnijMysz;
{ zwolnienie pamieci potrzebnej na zapamietywanie tla pod kursorem }

procedure MouseShow(var mx, my, mp : Integer);
{ wyswietlenie kursora myszy oraz przekazanie jej wspolrzednych (mx i my)}
{ oraz stanu nacisnietych klawiszy (mp  1-lewy, 2-prawy                  }

procedure MouseNot;
{ ukrycie kursora myszy }

procedure ZwolnijKlawisz;
{ procedura "czeka" na zwolnienie klawiszy myszy od stamu mp=0 }

procedure kl(var z:char);
{ procedura czyta klawisz z }

procedure InicjujGrafike;
{ inicjacja grafiki SVGA 640x480 }

procedure ZamknijGrafike;
{ zamkniecie trybu graficzenego }

procedure Myszkolumny(lewo,prawo:integer);
{ ustalenie ilosci kolumn kursora myszy od lewa do prawa }

procedure Myszwiersze(lewo,prawo:integer);
{ ustalenie ilosci wierszy myszy kursora od gory do dolu }

procedure MousePos(var x,y,p:integer);
{ zwraca pozycje kursora myszy }

procedure dz;
{ dzwiek }

implementation

uses
  ekran;

const
  MouseInt = $33; {przerwanie obslugujace mysz}

type
  {typ dla palety BMP}
  TPAletaBMP = record
               Blue  : byte;
               Green : byte;
               Red   : byte;
             end;

  {typ dla palety ekranu}
  TPaletaSCR = record
              Red   : byte;
              Green : byte;
              Blue  : byte;
            end;

var
  BMPPalette: array [0..255] of TPaletaBMP;
  ScrPalette: array [0..255] of TPaletaSCR;
  regs : Registers;

procedure dz;
begin
  sound(200);
  delay(100);
  nosound;
end;

Procedure Paleta;
{ korzysta z globalnej zmiennej BmpPalette i na jej podstawie ustala globalna }
{ ScrPalette ustawiajac tez palete kolorow                                   }
var i:integer;
begin
  for i := 0 to 255 do
    begin
      ScrPalette[i].Red := BMPPalette[i].Red shr 2;
      ScrPalette[i].Green := BMPpalette[i].Green shr 2;
      ScrPalette[i].Blue := BMPpalette[i].Blue shr 2;
    end;
  regs.ah := $10;
  regs.al := $12;
  regs.bx := 0;
  regs.cx := 256;
  regs.es := Seg (ScrPalette);
  regs.dx := Ofs (ScrPalette);
  intr ($10,regs);
end;

Procedure sciemnij;
{ stopniowo przeprowadza kolory do czarnych }
{ korzysta z ScrPalette                     }
const szybkosc=1;
var i,j:byte;
begin

  for i:=0 to 65 div szybkosc do
  begin
    for j := 0 to 256-1 do
      begin
        if ScrPalette[j].Red>szybkosc then ScrPalette[j].Red := ScrPalette[j].red-szybkosc;
        if ScrPalette[j].Green>szybkosc then ScrPalette[j].Green :=ScrPalette[j].green-szybkosc;
        if ScrPalette[j].Blue>szybkosc then ScrPalette[j].Blue :=ScrPalette[j].blue-szybkosc;
      end;
    regs.ah := $10;
    regs.al := $12;
    regs.bx := 0;
    regs.cx := 256;
    regs.es := Seg (ScrPalette);
    regs.dx := Ofs (ScrPalette);
    intr ($10,regs);
end;

end;

procedure odczytbmp(nazwa:string);
var
  f:file;
  i,j:integer;
  b:byte;
  a:array[0..1024]of byte;

begin
  assign(f,nazwa);
  reset(f,1);
  seek(f,54);{ mamy ustalony foramt wiec poczatek (informacje o formacie) nas }
             { nie obchodza                                                   }

  {wczytanie palety}
  blockRead(f,a,256*4);
  i:=0;
  for j:=0 to 255 do begin
    BMPPalette[j].blue:=a[i];inc(i);
    BMPPalette[j].green:=a[i];inc(i);
    BMPPalette[j].red:=a[i];inc(i);
    inc(i);
  end;

  sciemnij;{przyciemnienie kolorow}

  {wczytanie obrazka}
  for j:=0 to 480-1 do for i:=0 to 640-1 do begin
    if i=0 then blockRead(f,a,640);
    putpixel(i,480-j,a[i]);
  end;
  close(f);

end;


const tryb_SVGA=2;{tryb 640x480 przy 256 kolorach}

{$F+}
function DetectVGA256 : Integer;
var Vid : Integer;
begin
  DetectVGA256 := tryb_SVGA;    {ustalenie trybu}
end;

procedure initSVGA;
{ inicjacja SVGA }
var GraphMode, GraphDriver : integer;
begin
  GraphDriver := InstallUserDriver('svga256',@DetectVGA256);
  GraphDriver := Detect;
  InitGraph(GraphDriver,GraphMode,'program\');
end;
{$F-}


procedure zwolnijKlawisz;
var mx,my,mp:integer;
begin
 repeat
   MouseShow(mx,my,mp);
 until mp=0;
 MouseNot;
end;

procedure kl(var z:char);
begin
  z:=readkey;
  if z=#0 then z:= readkey;
end;

procedure InicjujGrafike;
{inicjacja grafiki SVGA}
var
  sterownik, tryb: integer;
begin
  initsvga;
end;

procedure ZamknijGrafike;
begin
  CloseGraph;
end;

var
  oldmx,oldmy:integer;{ poprzednie polozenie kursora myszy }
  MyszTlo:pointer;{wskaznik do zapamietania tla pod kursorem myszy}
  juzTlo:boolean;{czy wstawiac juz tlo - bylo juz zapamietane }

const
  TlomX=14;
  Tlomy=20;
  jakosc=4;

procedure MousePos(var x,y,p:integer);
begin
  regs.ax := $3;
  intr(MouseInt,regs);
  x:=regs.cx div jakosc;
  y:=regs.dx div jakosc;
  p:=regs.bx;
end;

procedure MouseShow;
begin
  MousePos(mx,my,mp);
  if (oldmx<>mx) or (oldmy<>my) or not juztlo then begin
    if (juzTlo) then begin
      PutImage(OldMx,OldMy,MyszTlo^,normalput);
    end;
    juzTlo:=true;
    GetImage(mx,my,mx+TlomX,my+TlomY,MyszTlo^);
    WstawRysunek(mysza,mx,my);{wstawienie kursora myszy}
    oldmx:=mx;
    oldmy:=my;
  end;
end;

procedure MouseNot;
begin
  if juzTlo then begin
    PutImage(OldMx,OldMy,MyszTlo^,0);
    juzTlo:=false;
  end;
end;

procedure MyszKolumny;
begin
  regs.ax:=7;
  regs.cx:=lewo;
  regs.dx:=prawo;
  intr(MouseInt,regs);
end;

procedure MyszWiersze;
begin
  regs.ax:=8;
  regs.cx:=lewo;
  regs.dx:=prawo;
  intr(MouseInt,regs);
end;

procedure Czulosc(pozioma,pionowa:integer);
{ ustala czylosc myszy }
begin
  regs.ax:=15;
  regs.cx:=pozioma;
  regs.dx:=pionowa;
  intr(mouseint,regs);
end;

function MouseInit;
begin
  regs.ax := $0;
  intr(MouseInt,regs);
  if regs.ax = $ffff then MouseInit := true
                     else MouseInit := false;

  {ustalenie ilosci wierszy i kolumn myszy}
  Myszwiersze(0,480*jakosc);
  Myszkolumny(0,(640-15)*jakosc);

  getMem(myszTlo,TloMx*TloMy+4);
  {przydzielenie pamieci na tlo pod kurasorem mysz}

  juzTlo:=false;
  czulosc(2,2);{ustalenie czulosci}
  oldmx:=0;oldmy:=0;
end;

Procedure ZwolnijMysz;
begin
  freeMem(myszTlo,TloMx*TloMy+4);
end;

end.