unit gracz;
{ modul do programu Szewc, obslugujacy gracza }
{ autor: Marcin Beniamin Stefaniak             }

interface
uses
  crt, typy, ekran, graph, obsluga;

type
  {wynik wyboru pocji}
  TWynik=(WjeszczeNic,Wruch, Wundo, Wredo, WkoniecGry, WnowaGra, WwczytajPlansze, WOpcje);

procedure TuraCzlowiek(var pole:TPlansza;var x,y,k:integer;nr :byte;var wynik:TWynik);
{ wykonanie ruchu przez czlowieka z ustaleniem ktora krawedz zajeta (x,y,k)}
{ lub nie zajecie zadnej krawedzi jesli wczesniej przeciwnik uzyskal       }
{ punkty                                                                   }
{ "wynik" przyjmuje wartosc WRuch jesli gracz wykonal ruch, w przeciwnym   }
{ razie "wynik" przyjmuje wartosc "WJeszczeNic"                            }
{ "nr" informuje ktory gracz wykonuje ruch                                 }
{ korzysta ze zmiennych globalnych ktore inicjuje procedura initGracz       }

procedure initGracz;
{ inicjacja gracza zmienia zmienne globalne z ktorych korzysta procedura }
{ TuraCzlowika                                                            }

function wczytajPlansze(nazwa:string;var m,n:integer;var p:TPlansza):boolean;
{wczytanie planszy (m,n i p) z pliku o nazwie nazwa, false jesli niepomyslne}
{plik jest typu TFileOfPairs = file of TPair                                }

function ZapiszPlansze(nazwa:string; m,n:integer;p:TPlansza):boolean;
{zapisanie planszy (m,n i p) w pliku o nazwie nazwa, false jesli niepomyslne}
{plik jest typu TFileOfPairs = file of TPair                                }

procedure opcje(var p:TPlansza;var wynik:TWynik);
{ wybor opcji gry za pomoca myszki                                          }
{ wynik przyjmuje wartosc wybranej opcji                                    }
{ jesli zostala wybrana opcja "wczytaj plansze" to jest modyfikowana        }
{ palnsza p                                                                 }
{ polozenie opcji na ekranie pobiera ze stalej Okno typu TOkna              }
{ zdefiniowanej w module typy                                               }

implementation

var iOld,jOld,kOld:integer;{zmienne potrzeben przy wyborze ruchyu         }
                           {zawieraja wsp. ostatnio "zaznaczonej" krawedzi}

procedure initGracz;
begin
 iOld:=1;jOld:=1;kOld:=1;
end;
procedure opcje(var p:TPlansza;var wynik:TWynik);
var i:ROkna;{zmienna wyliczeniowa uzyta do wyboru opcji}
    mx,my,mp:integer;{wsp. myszy i przycisk}
    point:pointer;{zmienna do zapamietania tla pod rysunkiem}
    kod_bl:integer;{zmienna badajaca poprawnosc operacji Val }
    txt:string; {zmienna tekstowa uzyta przy operacjach czytania}
begin
  {aby wejsc do petli}
  mx:=1000;
  wynik:=WJeszczeNic;

  while (mx>liniaOpcji)and(wynik=WJeszczeNic) do begin
    MouseShow(mx,my,mp);

    {sprawdzenie czy mysz znajduje sie w "zasiegu" jednej z opcji}
    for i:=gr1 to g4 do begin
      if (mp=1) and w(mx,my,okno[i].x1,okno[i].y1,okno[i].x2,okno[i].y2) then begin
        MouseNot;
        case i of
        gr1:{opcja wyboru czlowieka lub komputera jako gracza 1 }
        begin
          gracze.info[1].czlowiek:= not gracze.info[1].czlowiek;
          if gracze.info[1].czlowiek then WstawRysunek(glowa,okno[gr1].x1,okno[gr1].y1)
                                else WstawRysunek(monitor,okno[gr1].x1,okno[gr1].y1);
          ZwolnijKlawisz;
        end;
        gr2:{opcja wyboru czlowieka lub komputera jako gracza 2 }
        begin

          gracze.info[2].czlowiek:= not gracze.info[2].czlowiek;
          if gracze.info[2].czlowiek then WstawRysunek(glowa,okno[gr2].x1,okno[gr2].y1)
                                else WstawRysunek(monitor,okno[gr2].x1,okno[gr2].y1);
          ZwolnijKlawisz;
        end;
        undo:{opcja undo}
        if not pusty(sundo) then begin
          WstawRysunek(undowl,okno[i].x1,okno[i].y1);
          ZwolnijKlawisz;
          WstawRysunek(undowyl,okno[i].x1,okno[i].y1);
          wynik:=WUndo;
        end;
        redo:{opcja redo}
        if not pusty(sredo) then begin
          WstawRysunek(redowl,okno[i].x1,okno[i].y1);
          ZwolnijKlawisz;
          WstawRysunek(redowyl,okno[i].x1,okno[i].y1);
          wynik:=WRedo;

        end;

        g1:{opcja wczytania planszy}
        begin
          WstawRysunek(guzikWl,okno[i].x1,okno[i].y1);
          ZwolnijKlawisz;
          WstawRysunek(ramka,170,150);
          setcolor(czarny);
          outtextxy(190,180,'Podaj nazwe pliku:');
          Repeat
            czytaj(199,200,bialy,12,nazwaPliku,12,1,5);
          until (nazwaPliku='') or wczytajPlansze(nazwaPliku,m,n,p);
          WstawRysunek(guzikWyl,okno[i].x1,okno[i].y1);
          if nazwaPliku<>'' then Wynik:=WwCzytajPlansze
                           else Wynik:=WnowaGra;
        end;
        g2:{opcja zapisania planszy}
        begin
          WstawRysunek(guzikWl,okno[i].x1,okno[i].y1);
          ZwolnijKlawisz;
          getmem(point,imagesize(170,150,370,260));
          getimage(170,150,170+200,150+110,point^);
          WstawRysunek(ramka,170,150);
          setcolor(czarny);
          outtextxy(190,180,'Podaj nazwe pliku:');
          Repeat
            czytaj(199,200,bialy,12,nazwaPliku,12,1,5);
          Until (ZapiszPlansze(nazwapliku,m,n,p))or(nazwaPliku='');
          WstawRysunek(guzikWyl,okno[i].x1,okno[i].y1);
          putimage(170,150,point^,0);
          freemem(point,imagesize(170,150,370,260));
        end;
        g3:{opcja nowa gra}
        begin
          WstawRysunek(guzikWl,okno[i].x1,okno[i].y1);
          ZwolnijKlawisz;
          WstawRysunek(ramka,170,150);
          setcolor(czarny);
          outtextxy(200,180,'Wysokosc:');
          repeat
            str(m,txt);
            czytaj(273,175,bialy,0,txt,2,2,5);
            val(txt,m,kod_bl);
          until (kod_bl=0)and(m in [1..zakres]);
          setcolor(czarny);
          outtextxy(200,215,'Szerokosc:');
          repeat
            str(n,txt);
            czytaj(279,210,bialy,0,txt,2,2,5);
            val(txt,n,kod_bl);
          until (kod_bl=0)and(n in [1..zakres]);
          WstawRysunek(guzikWyl,okno[i].x1,okno[i].y1);
          wynik:=WNowaGra;
        end;
        g4:{opcja wyjscie z programu}
        begin
          WstawRysunek(guzikWl,okno[i].x1,okno[i].y1);
          ZwolnijKlawisz;
          WstawRysunek(guzikWyl,okno[i].x1,okno[i].y1);
          wynik:=WkoniecGry;
        end;
        naz1:czytaj(okno[naz1].x1,okno[naz1].y1,0,bialy,gracze.info[1].nazwa,10,1,4);
        naz2:czytaj(okno[naz2].x1,okno[naz2].y1,0,bialy,gracze.info[2].nazwa,10,1,4);
        end{case}
      end;
    end;


  end;
end;

procedure turaCzlowiek;

  procedure zmien(var p:TPlansza;var i,j,krawedz:integer;nr:byte;var wynik:Twynik);
  { procedura pozwala na wybranie krawedzi, pokazujac wizualnie wybieranie }
  { krawedzi                                                               }
  { zmienia i,j,k; krawedzi zaznacza kolorem kolor[nr]                     }
  { daje "wynik" WRuch jesli dokonano ruchu lub WJeszczeNic jesli wybrano  }
  { opcje  (kursor myszy przekroczyl linie opcji                           }

  var
    ii,jj,kk,mx,my,mp:integer;
    z:char;

  begin


    mx:=1;
    wynik:=WJeszczeNic;



    if i=0 then begin
     i:=iOld;
     j:=jOld;
     krawedz:=kOld;
    end else begin
     iOld:=i;
     jOld:=j;
     kOld:=krawedz;
    end;



    mouseNot;
    if p[i,j].pol[k]<>nic then RysujLinie(i,j,k,bialy,0)
                          else RysujLinie(i,j,k,kolor[nr],1);


    {aby wejsc do petli}

    while (wynik=Wjeszczenic)and(mx<liniaOpcji) do begin
      MouseShow(mx,my,mp);
      {ustalenie czy i na ktorej krawedzi znajduje sie kursor myszy}
      for ii:=1 to m do for jj:=1 to n do for kk:=1 to 2 do begin
        if (kk=pionowa) and (p[ii,jj].pol[kk]=nic) then begin
         if ((jj=1)and w(mx,my,odlx+n*dlx-zak, odly+(ii-1)*dly+zak,odlx+n*dlx+zak,odly+ii*dly-zak )) or
            w(mx,my,odlx+(jj-1)*dlx-zak,odly+(ii-1)*dly+zak, odlx+(jj-1)*dlx+zak,odly+ii*dly-zak ) then begin
            i:=ii;
            j:=jj;
            krawedz:=kk;
            if (mp=1)and(p[i,j].pol[krawedz]=nic) then wynik:=WRuch;
          end;
        end;

          if (kk=pozioma) and (p[ii,jj].pol[kk]=nic) then begin
            if( (ii=1) and w(mx,my,odlx+(jj-1)*dlx+zak,odly+m*dly-zak, odlx+jj*dlx-zak,odly+m*dly+zak )) or
             w(mx,my,odlx+(jj-1)*dlx+zak,odly+(ii-1)*dly-zak,odlx+jj*dlx-zak,odly+(ii-1)*dly +zak) then begin
              i:=ii;
              j:=jj;
              krawedz:=kk;
              if (mp=1)and(p[i,j].pol[krawedz]=nic) then wynik:=WRuch;
            end;

          end;
        end;


      {wyboru krawedzi mozna tez dokonac za pomoca strzalek i spacji}
      if keypressed then begin
        kl(z);
        if (z=' ') and (p[i,j].pol[krawedz]=nic) then wynik:=WRuch;
        case z of
            gora:
              begin
                if krawedz=pionowa then begin
                  krawedz:=pozioma;
                end else begin
                  krawedz:=pionowa;
                  i:=tnij(i-1,m);
                 end;
              end;
            dol:
              begin
                if krawedz=pionowa then begin
                  krawedz:=pozioma;
                  i:=tnij(i+1,m);
                end else begin
                  krawedz:=pionowa;
                end;

              end;
            lewo:
              begin
                j:=tnij(j-1,n);
              end;
            prawo:
              begin
                j:=tnij(j+1,n);
              end;
         end{case};
       end;{keypressed;}

       if (iOld<>i)or(jOld<>j)or(kOld<>krawedz) then begin
         {jesli nastapil ruch}

         MouseNot;
         RysujLinie(i,j,k,kolor[nr],1);
         {zamalowanie strej}
         if p[iOld,jOld].pol[kOld]<>nic then RysujLinie(iOld,jOld,kOld,kolor[p[iOld,jOld].pol[kOld]],1)
                                        else ZakryjLinie(iOld,jOld,kOld,1);

         iOld:=i;
         jOld:=j;
         kOld:=krawedz;
       end;

    end{while};

    MouseNot;
    RysujLinie(iOld,jOld,kOld,kolor[p[iOld,jOld].pol[kOld]],1);
    {zakrycie lini wyboru podczas wyboru opcji}
    if wynik<>WRuch then
       if p[i,j].pol[k]<>nic then RysujLinie(i,j,k,kolor[p[i,j].pol[k]],1)
                             else ZakryjLinie(i,j,k,1);
    ZwolnijKlawisz;
  end;{zmien}


begin {tura gracza}

  wynik:=Wjeszczenic;
  if pelnaPlansza(pole) then begin
    x:=0;y:=0;k:=0;
  end else begin
    {jesli przeciwnik zdobyl punkty to nic nie robi}
    if punkty(pole,x,y,k,0)>0 then begin
      x:=0;y:=0;k:=0;
    end else zmien(pole,x,y,k,nr,wynik);
  end;
end;

function wczytajPlansze(nazwa:string;var m,n:integer;var p:TPlansza):boolean;
var
  i,j,k,io:integer;
  dane:Tpair;
  plik:TFileOfpairs;
begin
  for i:=1 to m do for j:=1 to n do for k:=1 to 2 do p[i,j].pol[k]:=nic;
  assign(plik,nazwa);
  {$i-}
  reset(plik);
  io:=ioresult;
  if io=0 then begin
    read(plik,dane);
    io:=ioresult;
  end;

  {$r-}
  {zabezpieczenie podczas otwierania pliku zlego formatu}
  if (io=0) and (dane.x in [1..zakres*2]) and (dane.y in [1..zakres*2]) then
  begin
    wczytajPlansze:=true;
    m:=dane.x;n:=dane.y;
    while not eof(plik) do begin
      read(plik,dane);
      if (dane.x>m) then begin
        dane.x:=dane.x-m;
        dane.y:=dane.y-n;
        k:=pozioma;
      end else begin
        k:=pionowa;
      end;
      p[dane.x,dane.y].pol[k]:=3;
    end;
    close(plik);
  end else begin
    wczytajPlansze:=false;
    dz;
  end;
  {$r+}
  {$i+}
end;


function ZapiszPlansze(nazwa:string; m,n:integer;p:TPlansza):boolean;
var
  i,j,k:integer;
  dane:Tpair;
  plik:TFileOfPairs;
begin
  zapiszPlansze:=false;
  assign(plik,nazwa);
  {$i-}
  rewrite(plik);
  {$i+}

  if (ioresult<>0)or(nazwa='') then begin
    dz;
    ZapiszPlansze:=false;
  end else begin
    ZapiszPlansze:=true;
    dane.x:=m;dane.y:=n;
    write(plik,dane);
    for i:=1 to m do for j:=1 to n do for k:=1 to 2 do if p[i,j].pol[k]<>nic then
    begin
      if k=pozioma then begin
        dane.x:=i+m;
        dane.y:=j+n;
      end else begin
        dane.x:=i;
        dane.y:=j;
      end;
      write(plik,dane);
    end;
    close(plik);
  end;
end;

end.