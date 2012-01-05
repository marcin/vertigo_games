program szewc;
{ program zaliczeniowy - gra logiczna Szewc }
{ autor: Marcin Beniamin Stefaniak          }
{ grupa p. Malinowskiego                    }
uses
  crt, gracz, typy, obsluga, ekran, graph, komputer;
const
  potrzebnaPamiec=200000;{ilosc wymaganej pamieci}
  szerokoscPlanszy=412;
  wysokoscPlanszy=412;

var
  i,j:integer; {zmienne wykorzystywanie w petlach}
  x, y, k:integer; {zmienne okreslajace pole na planszy }
  pkt:integer;{pomocnicza zmienna przy okreslaniu punktow }
  czasGry,punkt:array[1..2]of longint;{czas gry i punkty obu graczy }
  WyjdzZProgramu,NowaGra:boolean; { zmienne wykorzystwane w petlach}
  pole:TPlansza;{ plansza gry }
  NrGracza:integer; {numer aktualnie grajacego gracza }
  wynik:TWynik; { zmienna uzywana podczas wyboru opcji progamu }
  mx, my, mp:integer;{ zmienne dla polozenia i stanu klawiszy myszy}

procedure konfiguracja;
{ odczytanie konfiguracji zapisanej w pliku config.sys }
var f:file of TGracz ;
begin
  assign(f,'config.dat');
  {$i-}
  reset(f);
  {$i+}

  if ioresult=0 then begin
    read(f,gracze);
    close(f);
  end else begin
    gracze.info[1].czlowiek:=true;
    gracze.info[2].czlowiek:=false;
    gracze.info[1].nazwa:='Beniamin';
    gracze.info[2].nazwa:='Komputer';
    gracze.m:=5;
    gracze.n:=5;
  end;

  m:=gracze.m;
  n:=gracze.n;

end;

procedure zapiszKonfiguracje;
{zapisanie konfiguracji do pliku config.sys }
var f:file of TGracz ;
begin
  gracze.m:=m;
  gracze.n:=n;
  assign(f,'config.dat');
  {$i-}
  rewrite(f);
  {$i+}
  if ioresult=0 then begin
    write(f,gracze);
    close(f)
  end;
end;

procedure tytul;
{wyswietlenie strony tytulowej-informacyjnej }
const x1=160;y1=160;x2=470;y2=330;{informaje o wsp. wycinku oberazka}
      gdzieX=160;gdzieY=100;{gdzie wstawic wycinek}
var
  p:pointer;
  z:char;

begin
  getmem(p,imagesize(x1,y1,x2,y2));
  getimage(x1,y1,x2,y2,p^);
  ClearDevice;
  putimage(GdzieX,GdzieY,p^,0);
  paleta;
  freemem(p,imagesize(x1,y1,x2,y2));
  kl(z);
end;

{program glowny }
begin

  if not mouseinit then Writeln('Niezainicjowana mysz...') else
  if MaxAvail<PotrzebnaPamiec then  Writeln('Program wymaga ',
      PotrzebnaPamiec div 1000,' kB pamieci (aktualnie wolnej ',MaxAvail div 1000,' kB)')
  else begin

    {inicjacja}
    InicjujGrafike;
    randomize;
    OdczytBMP('rysunki.dat');

    {zapamietanie ustalonych wycinkow ekranu }
    for rodzaje:=mysza to ramka do ZapamietajRysunek(rodzaje);

    {wyswietlenie strony tytulowej}
    tytul;

    {inicjacja}
    Konfiguracja;
    WyjdzZProgramu:=false;
    wynik:=WJeszczenic;
    initStos(sundo);
    initStos(sredo);
    nazwaPliku:='';
    OdczytBMP('szewc.dat');
    inittab;{inicjacja "duzej" tablicy}
    paleta;{rozjasnenie kolorow - dotychczas byly czarne}


    {wypelnienie "duzej" tablicy}
    for i:=0 to 433 do for j:=0 to 430 do begin
      nadajTab(i,j,getpixel(i+25,j+25));
    end;


    While not WyjdzZProgramu do begin

      { wizualne przedstawienie graczy - czlowiek lub komputer }
      if gracze.info[1].czlowiek then WstawRysunek(glowa,okno[gr1].x1,okno[gr1].y1)
                                  else WstawRysunek(monitor,okno[gr1].x1,okno[gr1].y1);
      if gracze.info[2].czlowiek then WstawRysunek(glowa,okno[gr2].x1,okno[gr2].y1)
                                  else WstawRysunek(monitor,okno[gr2].x1,okno[gr2].y1);

      { kozystajac z "duzej" tablicy wyczyszczenie planszy gry }
      rysZTab(25,25,433+25,430+25);

      initGracz;

      dlx:=szerokoscPlanszy div n;
      dly:=wysokoscPlanszy div m;


      {wyczyszczenie planszy lub zakreslenie danych na poczatku krawedzi}
      if (wynik<>Wwczytajplansze) then
            for i:=1 to zakres do for j:=1 to zakres do for k:=1 to 2 do
              pole[i,j].pol[k]:=0
       else
             for i:=1 to m do for j:=1 to n do for k:=1 to 2 do
               if pole[i,j].pol[k]=3 then RysujLinie(i,j,k,kolor[3],2);



      punkt[1]:=0;punkt[2]:=0;
      czasGry[1]:=0;czasGry[2]:=0;
      RysujPlansze(pole,gracze.info[1].nazwa,gracze.info[2].nazwa, m, n);
      RysujPunkty(punkt[1],punkt[2],czasGry[1],czasGry[2]);
      x:=0;
      nowaGra:=false;
      NrGracza:=1;
      StartCzas;

      While not NowaGra do begin

        {graficzne przedstawienie mozliwosci wykonanai undo i redo}
        if pusty(sundo) then WstawRysunek(undowl,okno[undo].x1,okno[undo].y1)
                        else WstawRysunek(undowyl,okno[undo].x1,okno[undo].y1);
        if pusty(sredo) then WstawRysunek(redowl,okno[redo].x1,okno[redo].y1)
                        else WstawRysunek(redowyl,okno[redo].x1,okno[redo].y1);






        mousepos(mx,my,mp);

        wynik:=WJeszczeNic;

        if mx<liniaOpcji then

          if gracze.info[NrGracza].czlowiek=true then TuraCzlowiek(pole,x,y,k,NrGracza,wynik)
                                                 else begin
                                                   wynik:=WRuch;
                                                   TuraKomputer(pole,x,y,k);

                                                 end;




        if (wynik<>WRuch)or(pelnaPlansza(pole)) then opcje(pole,wynik);

        case wynik of
          Wruch:begin

            MouseNot;
            if x>0 then {jesli nastapil ruch - nie bylo pasowania}
            begin

              {dodane do stosu "undo" danych}
              dundo.x:=x;dundo.y:=y;dundo.k:=k;dundo.kto:=NrGracza;
              Dodaj(SUndo,DUndo);

              {wyczyszczenie stosu "redo"}
              wyczysc(sredo);

              {zaznaczenie posuniecia}
              RysujLinie(x,y,k,kolor[NrGracza],2);
              pole[x,y].pol[k]:=NrGracza;
              pkt:=punkty(pole,x,y,k,kolor[NrGracza]);
              inc(punkt[NrGracza],pkt);

              {aktualizacji czasu gry gracza}
              czasGry[NrGracza]:=czasGry[NrGracza]+DajCzas;
              StartCzas;{rozpoczecie odliczania czasu dla nastepnego ruchu}
              RysujPunkty(punkt[1],punkt[2],czasGry[1] div 100,czasGry[2] div 100);

              if pkt=0 then if NrGracza=1 then NrGracza:=2 else NrGracza:=1;
            end;
          end;
          Wundo:{opcja "undo"}
            begin
              StartCzas;{rozpoczecie odliczania czasu dla nastepnego ruchu}
              MouseNot;{ukrycie kursora myszy}

              {pobranie i aktualizacja danych}
              Pobierz(sUndo,DUndo);
              Dodaj(sRedo,DUndo);{dodanie do stosu "redo"}
              x:=Dundo.x;y:=Dundo.y;k:=Dundo.k;NrGracza:=Dundo.kto;
              czasgry[1]:=0;czasgry[2]:=0;
              pkt:=punkty(pole,x,y,k,-1);
              dec(punkt[NrGracza],pkt);
              RysujPunkty(punkt[1],punkt[2],czasGry[1] div 100,czasGry[2] div 100);
              ZakryjLinie(x,y,k,2);
              pole[x,y].pol[k]:=nic;
            end;
          Wredo:{opcja "redo"}
            begin
              StartCzas;{rozpoczecie odliczania czasu dla nastepnego ruchu}
              MouseNot;{ukrycie kursora myszy}
              {pobranie i aktualizacja danych}
              Pobierz(sRedo,DUndo);
              Dodaj(sUndo,DUndo);
              x:=Dundo.x;y:=Dundo.y;k:=Dundo.k;NrGracza:=Dundo.kto;
              czasgry[1]:=0;czasgry[2]:=0;
              pkt:=punkty(pole,x,y,k,kolor[NrGracza]);
              inc(punkt[NrGracza],pkt);
              RysujPunkty(punkt[1],punkt[2],czasGry[1] div 100,czasGry[2] div 100);
              RysujLinie(x,y,k,kolor[NrGracza],2);
              pole[x,y].pol[k]:=NrGracza;
              if pkt=0 then if NrGracza=1 then NrGracza:=2 else NrGracza:=1;

            end;
          WkoniecGry:
          begin
            NowaGra:=true;
            WyjdzZProgramu:=true;
          end;
          WNowaGra:
            begin
              NowaGra:=true;
            end;
          WWczytajPlansze:
          begin
            NowaGra:=true;
          end;
        end;{case}


      end;{whiel not nowagra}


      {wyczyszczenie stosow "undo" i "redo"}
      wyczysc(sundo);
      wyczysc(sredo);




    end{wyjdz zprogramu};

    sciemnij;{sciemnienie kolorow}

    {zwolnienie pamieci}
    for rodzaje:=mysza to ramka do ZwolnijRysunek(rodzaje);
    ZamknijGrafike;
    zwolnijmysz;
    zwolnijTab;
    zapiszKonfiguracje;{zapisanie konfiguracji}
  end;{wystarczajaco pamieci i zainstalowana mysz}

end.