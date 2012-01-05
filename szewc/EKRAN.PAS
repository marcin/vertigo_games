unit ekran;
{ modul obslugujacy ekran dla progrmau Szewc }
{ autor: Marcin Beniamin Stefaniak           }

interface
uses
  obsluga, typy, graph, crt;

const
  liniaOpcji=470;{na prawo od tej linii zaczynaja sie opcje}

procedure RysujPlansze(var pole:TPlansza;nazwa1,nazwa2:string;wysokosc, szerokosc:integer);
{ rysuje "krzyzyki" na planszy w zaleznosci od szerokosci i wysokosci   }
{ wpisujac jednczesnie nazwy graczy                                     }

procedure RysujLinie(i,j,k,kolor,ll:integer);
{ rysuje krawedz i,j,k w o szerokosci ll }

procedure ZakryjLinie(i,j,k,l:integer);
{ zakrywa linie i,j,k o szerokosci l tlem z DuzejTablicy }

function punkty(p:TPlansza;i,j,k,kolor:integer):byte;
{ funkcja zwraca wartosc rowna ilosci punktow za postawienie krawedzi }
{ w punkcie i,j,k                                                     }
{ kolor to kolor punktowanego kwadratu i jesli k=-1 to nalozenie tla  }
{ z DuzejTablicy, a jesli kolor=0 to nie rysujemy kwadratu            }

procedure RysujPunkty(pkt1,pkt2:integer;czas1,czas2:longint);
{ aktualizuje punkty i czas gry graczy }

procedure czytaj(x,y,kolTla,kolTxt:integer;var txt:string;ile,co,boki:integer);
{ porcedura czytajaca w trybie graficznym - podobna do readln              }
{ x i y to wspolrzedne lewego gornego naroznika okna czytania              }
{ "kolTla" to kolor tla okna czytania, kolTxt to kolot tekstu              }
{ "ile" okresla ilosc mozliwych do wczytania znakow                        }
{ "co" ustala czy moga byc czytane tylko cyfry (co=2), czy wszystkie znaki }
{ (co=1)                                                                   }
{ "boki" to odleglosc krawedzi okna czytania od tekstu czytanego           }

function PobierzTab(x,y:longint):byte;
{ pobranie wartosci z komorki x,y "duzej" tablicy}

procedure initTab;
{ inicjacja "duzej" tablicy - przydzielenie pamieci }

procedure NadajTab(x,y,wart:longint);
{ nadane komorce x,y duzej tablicy wartosci wart }

procedure RysZTab(x1,y1,x2,y2:integer);
{ procedura wyswietlajaca czesc zapamietanego w tablicy ekranu }

procedure zwolnijTab;
{ zwolnienie pameici wykorzystywanej przez "duza" tablice}

procedure ZapamietajRysunek(r:rodzaj);
{ zapamietanie czesci ekrau okreslonego stala "r" typu rodzaj z
{ jednoczesnym przydzialem pamieci }

procedure ZwolnijRysunek(r:rodzaj);
{ zwolnienie pamieci dla rysunku okreslonego stala "r" typu rodzaj}

procedure WstawRysunek(r:rodzaj;px,py:integer);
{ wstawienie zapamietanego uprzednio rysunku okreslonego stala "r" typu }
{ rodzaj na ekranie w miejscu o lewym gornym wirzcholku w pkt. px,py    }

implementation

{ "duza" tablica potrzebna jest do odznaczania krawedzi w opcji Undo }
{ oraz w momencie nowej gry do "zakrycia" efektow gry poprzedniej    }
{ Nie mozna stworzyc "normalnej" talbicy planszy - za duzo danych,    }
{ wiec stworzylem wlasna - wolniejsza, ale pojemniejsza tablice      }

{typ i zmienna dla "duzej" tablicy}
type
  TDuzaTablica=array[0..433,0..144] of byte;
var
  DuzaTablica:array[1..3]of ^TDuzaTablica;

procedure RysujPlansze;
const bok=4;
var i,j,k:integer;
    txt:string;
begin
  setcolor(bialy);
  for i:=0 to wysokosc do
  for j:=0 to szerokosc do begin
    if i<wysokosc then line(odlx+j*dlx,odly+ i*dly,odlx+ j*dlx,odly+ i*dly+zak );
    if j<szerokosc then line(odlx+j*dlx,odly+ i*dly,odlx+ j*dlx+zak,odly+ i*dly );
    if i>0 then line(odlx+j*dlx,odly+ i*dly,odlx+ j*dlx,odly+ i*dly-zak );
    if j>0 then line(odlx+j*dlx,odly+ i*dly,odlx+ j*dlx-zak,odly+ i*dly );
  end;
  SetFillStyle(1,czarny);
  setcolor(bialy);
  bar(500,59,600,68);
  outtextxy(okno[naz1].x1+bok,okno[naz1].y1+bok,nazwa1);
  bar(500,182,600,192);
  outtextxy(okno[naz2].x1+bok,okno[naz2].y1+bok,nazwa2);
end;

procedure ZakryjLinie;
begin
  j:=j-1;
  i:=i-1;
  setfillstyle(0,0);
  if k=pionowa then begin
    rysZTab(odlx+j*dlx-l,odly+ i*dly+zak, odlx+j*dlx+l, odly+(i+1)*dly-zak );
    if j=0 then rysZTab(odlx+n*dlx-l,odly+ i*dly+zak, odlx+n*dlx+l,odly+ (i+1)*dly-zak );
  end;
  if k=pozioma then begin
    rysZTab(odlx+j*dlx+zak,odly+ i*dly-l, odlx+(j+1)*dlx-zak, odly+i*dly+l );
    if i=0 then rysZTab(odlx+j*dlx+zak,odly+ m*dly-l, odlx+(j+1)*dlx-zak,odly+ m*dly+l );
  end;
end;

procedure RysujLinie;
var l:integer;
begin
  j:=j-1;
  i:=i-1;
  setcolor(kolor);
  if k=pionowa then
  for l:=-ll to ll do begin
    if abs(l)=2 then setcolor(0) else setcolor(kolor);
    line(odlx+j*dlx+l,odly+ i*dly+zak, odlx+j*dlx+l, odly+(i+1)*dly-zak );
    if j=0 then line(odlx+n*dlx+l,odly+ i*dly+zak, odlx+n*dlx+l,odly+ (i+1)*dly-zak );
  end;
  if k=pozioma then
  for l:=-ll to ll do begin
    if abs(l)=2 then setcolor(0) else setcolor(kolor);
    line(odlx+j*dlx+zak,odly+ i*dly+l, odlx+(j+1)*dlx-zak, odly+i*dly+l );
    if i=0 then line(odlx+j*dlx+zak,odly+ m*dly+l, odlx+(j+1)*dlx-zak,odly+ m*dly+l );
  end;
end;

procedure RysujPunkty(pkt1,pkt2:integer;czas1,czas2:longint);
const bok=4;
var txt,t2:string;
begin
  SetFillStyle(1,czarny);
  setcolor(bialy);

  bar(577,92,600,100);
  str(pkt1,txt);
  outtextxy(578,93,txt);


  bar(577,108,600,117);
  str(czas1,txt);
  outtextxy(578,109,txt);

  bar(577,216,600,224);
  str(pkt2,txt);
  outtextxy(578,217,txt);
  bar(577,232,600,240);
  str(czas2,txt);
  outtextxy(578,233,txt);
end;

function punkty(p:TPlansza;i,j,k,kolor:integer):byte;
const
  szx=7;szy=7;{odleglosc srodkow kwadratow od obwodek}
var
  pkt:byte;

  procedure rys(x1,y1,x2,y2:integer);
  {procedura rysujaca kwadrat jesli zdobyto punkt}
  var i,j,k,sr:integer;
  begin
    if kolor=-1 then begin
      ryszTab(x1,y1,x2,y2);
    end else begin
      setcolor(kolor);
      sr:=x1+(x2-x1)div 2;
      for i:=0 to (x2-x1) div 4 do begin
        line(sr-i*2,y1,sr-i*2,y2);
        line(sr+i*2,y1,sr+i*2,y2);
      end;
      setcolor(czarny);
      rectangle(x1,y1,x2,y2);
    end;
  end;

begin{punkty}
  pkt:=0;
  if kolor>0 then setfillstyle(1,kolor);
  if i>0 then begin

    p[i,j].pol[k]:=nic;
    if (kwadrat(p,i,j)=3)
         then begin
           inc(pkt);
           if kolor<>0 then Rys(odlx+(j-1)*dlx+szx,odly+(i-1)*dly+Szy,odlx+j*dlx-szx,odly+i*dly-szy);
         end;
    if (k=pozioma) then begin
    if m=1 then begin
      if kwadrat(p,i,j)=2 then begin
        inc(pkt);
        if kolor<>0 then Rys(odlx+(j-1)*dlx+szx,odly+(i-1)*dly+Szy,odlx+j*dlx-szx,odly+i*dly-szy);
      end;
    end else begin
      i:=tnij(i-1,m);
      if kwadrat(p,i,j)=3 then begin
        inc(pkt);
        if kolor<>0 then Rys(odlx+(j-1)*dlx+szx,odly+(i-1)*dly+Szy,odlx+j*dlx-szx,odly+i*dly-szy);
      end;
    end;
  end;

    if (k=pionowa) then begin
      if n=1 then begin
        if kwadrat(p,i,j)=2 then begin
        inc(pkt);
        if kolor<>0 then Rys(odlx+(j-1)*dlx+szx,odly+(i-1)*dly+Szy,odlx+j*dlx-szx,odly+i*dly-szy);
        end;
      end else begin
        j:=tnij(j-1,n);
        if kwadrat(p,i,j)=3 then begin
        inc(pkt);
        if kolor<>0 then Rys(odlx+(j-1)*dlx+szx,odly+(i-1)*dly+Szy,odlx+j*dlx-szx,odly+i*dly-szy);
        end
      end;
    end;

  end;
  punkty:=pkt;
end;

procedure czytaj(x,y,kolTla,kolTxt:integer;var txt:string;ile,co,boki:integer);
const
  zakes=60000;{czestotliwosc migania kursora}
  kursor=5;{dlugosc kursora}
var
  wys,licz,kol,z1,z2,dl:integer;
  z:char;


  procedure RysujKursor(k:byte);
  begin
    setcolor(k);
    line(x+textwidth(txt)+boki,y+boki+wys,x+textwidth(txt)+boki+kursor,y+boki+wys);
  end;

  procedure tlo;
  begin
    setcolor(0);
    rectangle(x,y,x+dl,y+2*boki+wys);
    setfillstyle(1,Koltla);
    bar(x+1,y+1,x+dl-1,y+2*boki+wys-1);
  end;

begin
  dl:=ile * textwidth(' ')+ 2*boki + kursor ;
  case co of
    2:begin z1:=48; z2:=57 end;
    else begin z1:=30;z2:=122;end
  end;
  wys:=textheight(' ');
  tlo;
  setcolor(kolTxt);
  outtextxy(x+boki,y+boki,txt);
  licz:=zakres;
  kol:=kolTxt;
  z:=#0;
  repeat
    inc(licz);
    delay(5);
    if licz>zakres then begin
      licz:=0;
      if kol=kolTxt then kol:=kolTla else kol:=kolTxt;
      RysujKursor(kol);
    end;
    if keypressed then begin
      kl(z);
      RysujKursor(kolTla);
      if z=Backspace then begin
        delete(txt,length(txt),1);
        tlo;
        setcolor(kolTxt);
        outtextxy(x+boki,y+boki,txt);
      end else if (ile>length(txt)) and (ord(z) in [z1..z2]) then begin
        txt:=txt+z;
        setcolor(kolTxt);
        outtextxy(x+boki,y+boki,txt);
      end;
    end;
  until (z=Enter)or(z=ESC);
  if z=ESC then txt:='';

end;

function PobierzTab(x,y:longint):byte;
var i:integer;
begin
  i:=1;
  while y>=145 do begin
    y:=y-145;
    i:=i+1;
  end;
  pobierzTab:=DuzaTablica[i]^[x,y];
end;

procedure InitTab;
{inincjacja "duzej" tablicy "}
var i:integer;
begin
  for i:=1 to 3 do new(DuzaTablica[i]);
end;

procedure zwolnijTab;
{inincjacja "duzej" tablicy "}
var i:integer;
begin
 for i:=1 to 3 do dispose(DuzaTablica[i]);
end;


procedure NadajTab(x,y,wart:longint);
var i:integer;
begin
  i:=1;
  while y>144 do begin
    y:=y-145;
    i:=i+1;
  end;
  DuzaTablica[i]^[x,y]:=wart;
end;

procedure RysZTab(x1,y1,x2,y2:integer);
var i,j:integer;
begin
  for i:=0 to (x2-x1) div 2 do begin
    for j:=y1 to y2 do begin
      putpixel(x1+i,j,pobierzTab(x1+i-25,j-25));
      putpixel(x2-i,j,pobierzTab(x2-i-25,j-25));
    end;
  end;
end;

procedure ZapamietajRysunek(r:rodzaj);
begin
  GetMem(dane[r].p,ImageSize(dane[r].x1,dane[r].y1,dane[r].x2,dane[r].y2));
  GetImage(dane[r].x1,dane[r].y1,dane[r].x2,dane[r].y2,dane[r].p^);
end;

procedure ZwolnijRysunek(r:rodzaj);
begin
  FreeMem(dane[r].p,ImageSize(dane[r].x1,dane[r].y1,dane[r].x2,dane[r].y2));
end;

procedure WstawRysunek(r:rodzaj;px,py:integer);
var
  xx,yy:^Word;
  i,x,y:integer;
  b:^byte;
begin
  xx:=Ptr(Seg(dane[r].p^),Ofs(dane[r].p^));
  yy:=Ptr(Seg(dane[r].p^),Ofs(dane[r].p^)+2);
  x:=0;y:=0;
  for i:=0 to (xx^)*(yy^) do begin
    inc(x);
    if x>xx^ then begin
      x:=0;
      inc(y);
    end;
    b:=Ptr(Seg(dane[r].p^),Ofs(dane[r].p^)+i+5);
    if (b^<dane[r].k1)or(b^>dane[r].k2) then putpixel(px+x,py+y,b^);
  end;
end;

end.