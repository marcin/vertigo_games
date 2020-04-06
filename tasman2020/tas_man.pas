Program Tasman                      ;
uses crt,graph,Dos,msttp;
type dysk=record
          q:array[0..109] of byte;
          spowolnienie:word;
          kod:string[7];
          nr:word;
          end;


var theend,etap,od_nowa,wyjscie,bonus1,bonus,koniec,qz,z7,x,y,m,i,barx,iy,ix,iy1,ix1:integer;
    size,size1,size2,size3,size4,size5,size6,size7,size8,size10,siz2,size_n1,size_n2,size_t1,size_t2,size_tr2:integer;
    size_tra1,size_tra2,size_tyt,size_ver:integer;
    kam,zg,w,q,q1,ed,ed_2:array[0..109] of byte;
    w2,p,p1,p2,p3,p4,p5,p6,p7,p8,p10,p_n1,p_n2,p_t1,p_t2,p_tr2,p_tra1,p_tra2,p_tyt,p_ver:pointer;
    e_z,z:char;
    z2:array['A'..'Z'] of char;
    zix,ziy,gdzie:real;
    spowolnienie_txt,tek:string[3];
    tekst,et,bon,mi,se:string[10];
    level:text;
    plik,plik1:file of dysk;
    etapy:dysk;
    wi,wy,kon,kamien1,kamien,diam,sp,diamenty,bonus2,i1,wolniej:integer;
    etap_czy,ETAP_O,e_q,od,ol,op,ow,sekkk,sekk,min2,sek2,min1,sek1,godz,min,sek,setne:word;
    blad_val,sp1,qq,ii,ii1,pocz:integer;
    filepoz:longint;
    sp_etap,oile,inf_y,spowolnienie,qqq,st_ix,st_iy,tlo1_2:word;
    tak:boolean;
    tytul_x,e_c,e_ix,e_iy:integer;
    l_pl:longint;
    l_pl_txt:string[20];

    nazwa_pr:string[20];
{    level1:file of record
                   end;}
    dobrze:boolean;
    czyF10:boolean;
    czy_ed,edytorr:boolean;
    odczyt,ktora_plansza,odn:word;
    code,kode,kod_txt,etap_txt:string[7];
    sterownik,tryb,mst,xx,yy,aa:integer;


label start,start1,start2,eenndd,poczatek_gry,probny_end,nr_etapu,koniec_plansz,ole;

{ c:\MST\vgainit.pas}

procedure xy;
begin
xx:=xx+aa;
if xx+aa>600 then begin xx:=0;yy:=yy+31;end;
end;


procedure tlo (nx,ny,mx,my:integer);
begin
  setfillstyle(1,7);
  bar(nx,ny,mx,my);
  setcolor(15);
  line(nx,ny,mx-1,ny);line(nx,ny+1,mx-2,ny+1);line(nx,ny,nx,my+1);line(nx+1,ny,nx+1,my);
  line(nx+2,ny,nx+2,my-1);
  line(nx+3,ny,nx+3,my-2);
  setcolor(8);
  line(nx+2,my,mx,my);line(nx+4,my-1,mx,my-1);line(mx,ny,mx,my);line(mx-1,ny+1,mx-1,my);line(mx-2,ny+1,mx-2,my);
  line(mx-3,ny+2,mx-3,my);
  line(nx,my+1,mx+1,my+1);line(mx+1,ny,mx+1,my+1);
end;

procedure tlo1 (nx,ny,mx,my,mn,mn1,mn2:integer);
begin
  setfillstyle(1,mn);
  bar(nx,ny,mx,my);
  setcolor(mn1);
  line(nx,ny,mx-1,ny);line(nx,ny+1,mx-2,ny+1);line(nx,ny,nx,my+1);line(nx+1,ny,nx+1,my);
  line(nx+2,ny,nx+2,my-1);
  line(nx+3,ny,nx+3,my-2);
  setcolor(mn2);
  line(nx+2,my,mx,my);line(nx+4,my-1,mx,my-1);line(mx,ny,mx,my);line(mx-1,ny+1,mx-1,my);line(mx-2,ny+1,mx-2,my);
  line(mx-3,ny+2,mx-3,my);
  line(nx,my+1,mx+1,my+1);line(mx+1,ny,mx+1,my+1);
end;

procedure tlo_(tkl,tkp,tks,tlox1,tloy1,tlox2,tloy2,czy:word);
var kolor:word;
begin

  SetColor(tkl);
  Line(tlox1-2,tloy1-2,tlox2+2,tloy1-2);
  Line(tlox1-2,tloy1-1,tlox2+1,tloy1-1);
  Line(tlox1-2,tloy1,tlox1-2,tloy2+2);
  Line(tlox1-1,tloy1,tlox1-1,tloy2+1);
  SetColor(tkp);
  Line(tlox2+2,tloy1-1,tlox2+2,tloy2+2);
  Line(tlox2+1,tloy1,tlox2+1,tloy2+2);
  Line(tlox1,tloy2+1,tlox2,tloy2+1);
  Line(tlox1-1,tloy2+2,tlox2+2,tloy2+2);
  if tks<16 then
  begin
    SetFillStyle(1,tks);
    Bar(tlox1,tloy1,tlox2,tloy2);
  end;
  SetColor(brown);
  if czy=2 then rectangle(tlox1-4,tloy1-4,tlox2+4,tloy2+4);
  if czy=1 then
  begin
    rectangle(tlox1-4,tloy1-4,tlox2+4,tloy2+4);
    SetColor(0);
    rectangle(tlox1-5,tloy1-5,tlox2+5,tloy2+5);
    rectangle(tlox1-3,tloy1-3,tlox2+3,tloy2+3);
  end;
  SetFillStyle(1,kolor);
end;








procedure poczatek;
begin
    SetActivePage(1);
    cleardevice;
    setcolor(14);
{    OutTextXY(200,130,'Poczekaj chwile...');}
    SetVisualPage(1);
    SetActivePage(0);
    SetViewPort(0,0,GetMaxX,GetMaxY,ClipOn);
    ClearDevice;



    Putimage(10,60,p_tyt^,normalput);
    Putimage(545,5,p_ver^,normalput);

    tlo_(7,8,brown,390,250,560,265,1);
  Assign(plik,'tasman.etp');
  Reset(plik);
  l_pl:=0;
  Repeat
    l_pl:=l_pl+1;
    read(plik,etapy);
  Until eof(plik);
  close(plik);



  SetTextStyle(11,0,red);
{  l_pl:=(l_pl-1)div 11;}
  Str(l_pl,l_pl_txt);
{  OutTextXY(5,10,'Maksymalny Nr planszy:');
  outtextxy(100,10,l_pl_txt);}
  setcolor(0);
  outtextxy(402,255,'Ilosc plansz: ');
  outtextxy(402,249,'   ,,');
  outtextxy(515,255,l_pl_txt);


    SetColor(brown);
    SetTextStyle(11,0,4);

        SetVisualPage(0);

    tytul_x:=0;
    delay(100);
        SetFillStyle(0,0);

        repeat
        if keypressed then z:=readkey;
        until not keypressed;

    for i:=0 to 15 do
    begin

              tytul_x:=tytul_x+1;
              putimage(tytul_x*10,170,p_tra1^,normalput);
              delay(70);
              bar(tytul_x*10,170,tytul_x*10+51,170+31);
              tytul_x:=tytul_x+1;
              putimage(tytul_x*10,170,p_tra2^,normalput);
              delay(70);
              bar(tytul_x*10,170,tytul_x*10+51,170+31);
              tytul_x:=tytul_x+1;
              putimage(tytul_x*10,170,p_tra1^,normalput);
              delay(70);
              bar(tytul_x*10,170,tytul_x*10+51,170+31);
              tytul_x:=tytul_x+1;
              putimage(tytul_x*10,170,p_tra2^,normalput);
              delay(70);
              bar(tytul_x*10,170,tytul_x*10+51,170+31);


              if i=2 then OutTextXY(100,160,'(C)');
              if i=2 then OutTextXY(100,160,'(C) MSt');
              if i=4 then OutTextXY(100,160,'(C) MSt VertigO');
              if i=6 then OutTextXY(100,160,'(C) MSt VertigO     Wisniew');
              if i=6 then OutTextXY(100,154,'                      ,    ');

              if i=8 then OutTextXY(100,160,'(C) MSt VertigO     Wisniew 1995');
              if i=8 then OutTextXY(100,154,'                      ,    ');


              if keypressed then i:=15;
                                      { z:=readkey;
                                       z:=upcase(z);
                                       if z='q' then i:=15;
                                 end;  }

    end;
    OutTextXY(100,160,'(C) MSt VertigO     Wisniew 1995');
    OutTextXY(100,154,'                      ,    ');

    SetColor(brown);
    rectangle(100+350-90-200-2-7,308-2,373+250+3,330+3);
        SetColor(brown);
    rectangle(100+350-90-200-3-7,308-3,373+250+4,330+4);
    SetTextStyle(2,0,6);{6}
i:=5;
    tlo1(i+100+350-90-200,308,163+350-100-120+i,330,brown,7,8);
    setcolor(0);
    OutTextXY(110+350-90-200+i,308,'F10-wyjscie');
    OutTextXY(111+350-90-200+i,308,'F10-wyjscie');
    SetColor(blue);
    OutTextXY(110+350-90-200+i,308,'F10');
    OutTextXY(111+350-90-200+i,308,'F10');

    {tlo(100+350-90,308,163+350-100,330);}

        i:=40;
    tlo1(100+350-90-i,308,163+350-100-i+17,330,brown,7,8);
    SetColor(0);
    SetTextStyle(2,0,6);

    OutTextXY(110+350-90-i,308,'I-info');
    OutTextXY(111+350-90-i,308,'I-info');
    SetColor(blue);
    OutTextXY(110+350-90-i,308,'I');
    OutTextXY(111+350-90-i,308,'I');

{    tlo(100+350,308,163+350,330);}
i:=37;
    tlo1(100+350-i,308,163+350+20-i,330,brown,7,8);
    SetColor(0);
    SetTextStyle(2,0,6);
    OutTextXY(110+350-i,308,'S-start');
    OutTextXY(111+350-i,308,'S-start');
    SetColor(blue);
    OutTextXY(110+350-i,308,'S');
    OutTextXY(111+350-i,308,'S');



{    tlo(550,308,373+250,330);}
i:=30+2;
    tlo1(550-i,308,373+250-12,330,brown,7,8);
    SetColor(0);
    SetTextStyle(2,0,6);
    OutTextXY(560-i,308,'E-edytor');
    OutTextXY(561-i,308,'E-edytor');
    SetColor(blue);
    OutTextXY(560-i,308,'E');
    OutTextXY(561-i,308,'E');
    SetTextStyle(1,0,10);
    settextstyle(2,0,6);
    Repeat
    z:=readkey;
    if (z='s') or (z='S') then
    begin
      pocz:=1;
      i:=37;
      setcolor(0);
      line(100+350-i,308,163+350+20-i,308);
    tlo1(100+350-i,308+1,163+350+20-i,330+1,brown,8,7);
    SetColor(0);
    SetTextStyle(2,0,6);
    OutTextXY(110+350-i,308+2,'S-start');
    OutTextXY(111+350-i,308+2,'S-start');
{    OutTextXY(110+350-i,308+2,'S-start');
    OutTextXY(111+350-i,308+2,'S-start');}
    SetColor(blue);
    OutTextXY(110+350-i,308+2,'S');
    OutTextXY(111+350-i,308+2,'S');
{    OutTextXY(110+350-i,308+2,'S');
    OutTextXY(111+350-i,308+2,'S');}
{      tlo1(100+350,308,163+350,330,brown,8,7);
      SetColor(0);
      SetTextStyle(2,0,6);
      OutTextXY(110+350,308,'Start');
      OutTextXY(111+350,308,'Start');
      SetColor(7);
      OutTextXY(110+350,308,'S');
      OutTextXY(111+350,308,'S');}
    end;
    if z=#68 then
    begin
      pocz:=3;
      i:=5;
      setcolor(0);
      line(i+100+350-90-200,308,163+350-100-120+i,308);
    tlo1(i+100+350-90-200,308+1,163+350-100-120+i,330+1,brown,8,7);
    setcolor(0);
    OutTextXY(110+350-90-200+i,308+2,'F10-wyjscie');
    OutTextXY(111+350-90-200+i,308+2,'F10-wyjscie');
    SetColor(blue);
    OutTextXY(110+350-90-200+i,308+2,'F10');
    OutTextXY(111+350-90-200+i,308+2,'F10');
{      tlo1(100+350-90-200,308,163+350-100-120,330,brown,8,7);
      setcolor(0);
      settextstyle(2,0,6);
      OutTextXY(110+350-90-200,308,'F10-wyjscie');
      OutTextXY(111+350-90-200,308,'F10-wyjscie');
      SetColor(7);
      OutTextXY(110+350-90-200,308,'F10');
      OutTextXY(111+350-90-200,308,'F10');}
    end;
    if (z='e') or (z='E') then
    begin
      pocz:=2;
      i:=30+2;
      setcolor(0);
      line(550-i,308,373+250-12,308);
    tlo1(550-i,308+1,373+250-12,330+1,brown,8,7);
    SetColor(0);
    SetTextStyle(2,0,6);
    OutTextXY(560-i,308+2,'E-edytor');
    OutTextXY(561-i,308+2,'E-edytor');
    SetColor(blue);
    OutTextXY(560-i,308+2,'E');
    OutTextXY(561-i,308+2,'E');
{      tlo1(550,308,373+250,330,brown,8,7);
      SetColor(0);
      SetTextStyle(2,0,6);
      OutTextXY(560,308,'Edytor');
      OutTextXY(561,308,'Edytor');
      SetColor(7);
      OutTextXY(560,308,'E');
      OutTextXY(561,308,'E');
      SetTextStyle(1,0,10);}

    end;

    if (z='i') or (z='I') then
    begin

            i:=40;
            setfillstyle(1,0);
            bar(100+350-90-i,308,163+350-100-i+17,330);
    tlo1(100+350-90-i,308+1,163+350-100-i+17,330,brown,8,7);

    SetColor(0);
    SetTextStyle(2,0,6);

    OutTextXY(110+350-90-i,308+2,'I-info');
    OutTextXY(111+350-90-i,308+2,'I-info');

    setcolor(blue);
    OutTextXY(110+350-90-i,308+2,'I');
    OutTextXY(111+350-90-i,308+2,'I');

      SetActivePage(1);
      cleardevice;

      tlo_(7,8,3,5+55,5,getmaxx-5-45,19,1);
      tlo_(7,8,3,5,30,getmaxx-5,53,1);
      tlo_(7,8,3,5,67+7+4,getmaxx-5,295,1);
      tlo_(7,8,3,360+20,308,getmaxx-5-20,getmaxy-5,1);

      SetColor(0);
      SetTextStyle(11,0,4);
      inf_y:=0;
      inf_y:=inf_y+8;
      OutTextXY(10,inf_y,'          TASMAN wersja 1.9 (c) MSt VertigO    kwiecien-czerwiec 1995               ');


      inf_y:=inf_y+25;

      OutTextXY(10,inf_y,'Program: Marcin Stefaniak (program napisany w Turbo Pascalu 7.0)                          ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'Grafika: Marcin Stefaniak, Magdalena Stefaniak  ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'                                         ');
      inf_y:=inf_y+10;
{      OutTextXY(10,inf_y,'Dzwiek:  wersja demonstracyjna nie posiada                                    ');}
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'                                                                             ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'Wskazowki:                                                                   ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'- kierujesz Tasmanem, ktory musi zebrac wszystkie pieniadze i wyjsc wyjsciem  ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'  ewakuacyjnym                                                               ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'- Tasman ginie gdy : upadnie mu na glowe jeden z przedmiotow     ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'                     zostanie porazony nitrogliceryna                        ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'                     rozgniecie go toczacy sie kamien                        ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'                     sprobuje wyjsc z etapu bez calego szmalu                 ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'- nitrogliceryna wybucha pod wplywem upadku na twarda powierzchnie, lub gdy  ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'  cos upadnie, lub wpadnie, na nia                                             ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'- wyjscie ewakuacyjne jest tylko jedno, nitrogliceryna nie niszczy go        ');
      inf_y:=inf_y+15;
      OutTextXY(10,inf_y,'Reszty dowiesz sie grajac...                                                 ');
      inf_y:=inf_y+25;
      OutTextXY(10,inf_y,'Opcja EDYTOR sluzy do tworzenia nowych plansz.                                 ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'Najpierw tworzysz plansze, a nastepnie (gdy nacisniesz Ctrt+Z) testujesz ja ');
inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'(grasz na niej).Jesli "przejdziesz" utworzona przez siebie plansze, zostanie ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'ona dolaczona do plansz na ktorych mozna grac. Jezeli ukonczenie jej nie  ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'bedzie mozliwe nacisnij F10-wtedy powrocisz do edytora i bedziesz mogl naniesc      ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'poprawki i znowu sprobowac przetestowac.                                     ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'Jesli znajdujesz sie w EDYTORZE to nacisniencie F10(wyjscie) spowoduje      ');
inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'porzucenie tworzenia plansz bez zapisu tego co zrobiles.                    ');
{      inf_y:=inf_y+40;}
{      OutTextXY(10,inf_y,'Jedynie pierwsze 10 etapow napewno da sie przejsc, gdyz                  ');
            inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'kolejne byly tworzone przez przypadkowe osoby.                         ');}

{      OutTextXY(10,inf_y,'Demo Tasmana zawiera tylko 10 etapow i jest okrojone, jesli chcesz kupic cala ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'gre TASMAN, lub inne programy, napisz:                                         ');}
      inf_y:=inf_y+30;
      OutTextXY(160,inf_y,'                              adres: Marcin Stefaniak                        ');
      inf_y:=inf_y+10;
      OutTextXY(160,inf_y,'                                     ul.Kosciuszki 48                        ');
      inf_y:=inf_y+10;
      OutTextXY(160,inf_y,'                                      08-112 Wisniew                         ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'                                                                             ');
      inf_y:=inf_y+10;

{      OutTextXY(10,inf_y,'                                                                             ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'Gra TASMAN kosztuje ok. 15 zl. Jesli chcesz kupic ja taniej mozesz przyslac  ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'wykonane na EDYTORZE wersji demonstracyjnej etapy (plik level.mst). ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'Gdy stworzysz 20 (sensownych) etapow i je przyslesz cena gry bedzie o polowe ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'nizsza.                                                                      ');
      inf_y:=inf_y+10;
      OutTextXY(10,inf_y,'W grze beda zawarte informacje o autorach poszczegolnych etapow.              ');}
{      OutTextXY(101,190,' Demo Tasmana zawiera tylko 5 etapow');
      OutTextXY(101,200,' W celu otrzymania calej gry przeslij');
      OutTextXY(101,210,'      na podany adres dyskietke.');
      OutTextXY(101,220,'Cena gry 50 zl (minimum 10 zl)');
      OutTextXY(101,230,'Na dyskietce mozesz przyslac etapy ');
      OutTextXY(101,240,'wykonane na "edytorze". Za kazde 10,');
      OutTextXY(101,250,'ktore beda nadawaly sie do wstawienia');
      OutTextXY(101,260,'do gry, obnizka ceny Tasmana o 50%.');
      OutTextXY(101,270,' Informacja o autorach poszczegolnych');
      OutTextXY(101,280,'    etapow bedzie zawarta w grze.');
      OutTextXY(101,300,'   adres:');
      OutTextXY(101,310,'   Marcin Stefaniak');
      OutTextXY(101,320,'   ul.Kosciuszki 48');
      OutTextXY(101,330,'    08-112 Wisniew ');}
      SetVisualPage(1);
      repeat
      until keypressed;
      SetActivePage(0);

      SetVisualPage(0);
      delay(500);
              i:=40;
    tlo1(100+350-90-i,308,163+350-100-i+17,330,brown,7,8);
    SetColor(0);
    SetTextStyle(2,0,6);

    OutTextXY(110+350-90-i,308,'I-info');
    OutTextXY(111+350-90-i,308,'I-info');
    SetColor(blue);
    OutTextXY(110+350-90-i,308,'I');
    OutTextXY(111+350-90-i,308,'I');

    end;
    until pocz<>0;

end;
{----------------------------plansza-----------------------------------}
Procedure plansza;
begin
for i:=100 to 109 do q[i]:=99;
koniec:=0;


ix:=100;iy:=0;x:=100;y:=100;
SetActivePage(1);
ClearDevice;
SetActivePage(0);
SetVisualPage(1);



SetViewPort(0,10,getmaxx,getmaxy,clipoff);
code:=etapy.kod;
if edytorr then code:=kode;

tlo_(7,8,brown,5,5,67,35,1);
SetTextStyle(21,0,21);
setcolor(0);
OutTextXY(23,10,'Kod:');
setcolor(0);
SetTextjustify(1,2);

OutTextXY(31+5,23,code);
SetTextjustify(0,2);



tlo(0,90,70,125);
tlo(0,130,70,165);
setcolor(red);
SetTextStyle(21,0,21);

  OutTextXY(1,100,' Punkty:');
  OutTextXY(1,140,' Czas:');

  SetColor(8);
  str(bonus,bon);
  setfillstyle(1,7);
  bar(20,110,65,117);
  OutTextXY(20,110,bon);
  OutTextXY(21,110,bon);



  SetTextStyle(15,0,3);
    tlo(0,getmaxy-14-15,80,getmaxy-15);
    OutTextXY(10,getmaxy-10-15,'F10-exit');
    SetColor(red);
    OutTextXY(10,getmaxy-10-15,'F10');

    SetTextStyle(15,0,3);
    tlo(0+500,getmaxy-14-15,80+510,getmaxy-15);
    OutTextXY(10+500,getmaxy-10-15,'ESC-start');
    SetColor(red);
    OutTextXY(10+500,getmaxy-10-15,'ESC');

    SetTextStyle(15,0,3);
    tlo(0+100,getmaxy-14-15,80+180,getmaxy-15);
    OutTextXY(10+100,getmaxy-10-15,'Spowolnienie:');
    Str(spowolnienie,spowolnienie_txt);
    OutTextXY(10+100+120,getmaxy-25,spowolnienie_txt);

tlo(85,-10,619,315);
SetColor(8);

  str(ktora_plansza,et);
  OutTextXY(349,304,et);
  OutTextXY(350,304,et);
for i:=0 to 99 do
  begin

    ix1:=ix+50;iy1:=iy+30;

    case q[i] of
      0:begin
         tlo1_2:=random(3);
         if tlo1_2=1 then putimage(ix,iy,p^,normalput);
         if tlo1_2=0 then putimage(ix,iy,p_tr2^,normalput);
         if tlo1_2=2 then putimage(ix,iy,p_n2^,normalput);
         end;
      1:putimage(ix,iy,p1^,normalput);
      2:putimage(ix,iy,p2^,normalput);
      3:putimage(ix,iy,p3^,normalput);
      4:putimage(ix,iy,p4^,normalput);
      5:putimage(ix,iy,p5^,normalput);
      6:putimage(ix,iy,p6^,normalput);
      7:putimage(ix,iy,p7^,normalput);
      8:putimage(ix,iy,p8^,normalput);
    end;
    ix:=ix+50;
    if ix=600 then
      begin
       ix:=100;
       iy:=iy+30;
      end;
end;
SetVisualPage(0);
end; {plansza}


                         {GRA}
{----------------------------------------------------------------------}


procedure gra;

label next;
begin
dobrze:=false;
czyf10:=false;
wolniej:=0;
GetTime(godz,min1,sek1,setne);

koniec:=0;
kon:=0;
diamenty:=0;
plansza;

  for i:=10 downto 0 do
  begin
    sound(i*100);
    delay(50);
  end;
  nosound;
kamien:=100;
kamien1:=100;

for i:=0 to 99 do
if q[i]=8 then wyjscie:=i;

for i:=0 to 99 do
if q[i]=3 then diamenty:=diamenty+1;

repeat
{kon:=0;
        if  q[kk+20]=7 then kon:=1;
       if kon=1 then koniec:=1;}


{Delay(m);}
GetTime(godz,min2,sek2,setne);
sek:=sek2-sek1;
min:=min2-min1;
sek:=sek+min*60;
str(sek,se);
SetColor(8);
SetFillStyle(1,7);
if sekk<>sek then
begin
  bar(20,150,65,162);
  OutTextXY(20,150,se);
  OutTextXY(21,150,se);
  sekk:=sek;
  sekkk:=sekkk+1;
  if sekkk=3 then begin sekkk:=0;bonus:=bonus-5;end;
end;







z:='%';
z7:=1;
if keypressed then      z:=readkey;
{if (z=#75)or (z=#72)or (z=#77)or (z=#80)then
begin
  sound(20);
  delay(20);
  nosound;
end;      }

if z=#113 then
  begin
    spowolnienie_txt:='';
    z:=readkey;
    spowolnienie_txt:=z;
    z:=readkey;
    spowolnienie_txt:=spowolnienie_txt+z;
    z:=readkey;
    spowolnienie_txt:=spowolnienie_txt+z;
    val(spowolnienie_txt,spowolnienie,blad_val);
    SetTextStyle(15,0,3);
    tlo(0+100,getmaxy-14-15,80+180,getmaxy-15);
    OutTextXY(10+100,getmaxy-10-15,'Spowolnienie:');
    Str(spowolnienie,spowolnienie_txt);
    OutTextXY(10+100+120,getmaxy-25,spowolnienie_txt);

  end;
od:=0;ol:=0;op:=0;ow:=0;
kamien:=kamien-1;
kamien1:=kamien1-1;
wolniej:=wolniej-1;
wy:=1;
if wolniej<0 then
For i:=99 downto 0 do
  begin
  wolniej:=spowolnienie;
{ if ow=0 then}
  if q[i]=2 then
     begin
     if (w[i]>0) and(wy<>10) then   {------------------WYBUCH---------------}
       if (q[i+10]=2) or (q[i+10]=3) or (q[i+10]=4) or (q[i+10]=5) or (q[i+10]=6)or (w[i]=2)then
         begin
         ow:=1;
         {if (q[i-1]=7)or(q[i+1]=7)or(q[i-10]=7)or(q[i+10]=7)then koniec:=1;}
         q[i]:=1;
         if (i mod 10>0)and(q[i-1]<>6)and(q[i-1]<>2) then q[i-1]:=1;
         if (i mod 10<9)and(q[i+1]<>6)and(q[i+1]<>2) then q[i+1]:=1;
         if (i>9)and(q[i-10]<>6)and(q[i-10]<>2) then q[i-10]:=1;
         if (i<90)and(q[i+10]<>6)and(q[i+10]<>2) then q[i+10]:=1;

         if (i mod 10>0)and(q[i-1]=2) then w[i-1]:=2;
         if (i mod 10<9)and(q[i+1]=2) then w[i+1]:=2;
         if (i>9)and(q[i-10]=2) then w[i-10]:=2;
         if (i<90)and(q[i+10]=2) then w[i+10]:=2;
         wi:=i;
         ix:=((i mod 10)*50)+100;
         iy:=(i div 10)*30 ;

         {putimage(ix,iy,p8^,normalput);
         if (i mod 10<9)and(q[i+1]<>6)and(q[i+1]<>2) then putimage(ix+50,iy,p8^,normalput);
         if (i mod 10>0)and(q[i-1]<>6)and(q[i-1]<>2) then putimage(ix-50,iy,p8^,normalput);
         if (i<90)and(q[i+10]<>6)and(q[i+10]<>2) then putimage(ix,iy+30,p8^,normalput);
         if (i>9)and(q[i-10]<>6)and(q[i-10]<>2) then putimage(ix,iy-30,p8^,normalput);}
         putimage(ix,iy,p10^,normalput);

         if (i mod 10<9)and(q[i+1]<>6)and(q[i+1]<>2) then putimage(ix+50,iy,p10^,normalput);
         if (i mod 10>0)and(q[i-1]<>6)and(q[i-1]<>2) then putimage(ix-50,iy,p10^,normalput);
         if (i<90)and(q[i+10]<>6)and(q[i+10]<>2) then putimage(ix,iy+30,p10^,normalput);
         if (i>9)and(q[i-10]<>6)and(q[i-10]<>2) then putimage(ix,iy-30,p10^,normalput);

         w[i]:=0;
         wy:=0;
         end;
     end;{2}

 {--------------------------------DO DOLU-----------------------------}

   if (q[i]=3) or (q[i]=4) or (q[i]=2) then
     begin

     if q[i+10]=1 then
       begin
       q1[i+10]:=1;
       q[i+10]:=q[i];
       ix:=((i mod 10)*50)+100;
       iy:=(i div 10)*30 ;
       if q[i]=2 then putimage(ix,iy+30,p2^,normalput);
       if q[i]=3 then putimage(ix,iy+30,p3^,normalput);
       if q[i]=4 then putimage(ix,iy+30,p4^,normalput);
       putimage(ix,iy,p1^,normalput);
       if q[i+20]=2 then w[i+20]:=2;
       if (q[i]=2)and (q[i+20]=3) or (q[i+20]=4)or(q[i+20]=5) or (q[i+20]=6) then w[i+10]:=2;
       q[i]:=1;
       q1[i]:=0;
       end
     else
       begin
       if  (q1[i]=1) and (q[i+10]=7)then koniec:=1;
       q1[i]:=0;
       end;
     {if q[i-10]=1 then q1[i-10]:=0;}




             {--------------------spadek w prawo-------------}
   {  if op=0 then}
     if (q[i+10]=2) or (q[i+10]=3) or (q[i+10]=4) or (q[i+10]=5) or (q[i+10]=6) or (q[i+10]=8)then
       begin
         if (q[i+1]=1) and (q[i+11]=1) and (i mod 10<9)then

         begin
         op:=1;
         {q1[i+10]:=1;}
         q[i+1]:=q[i];
         ix:=((i mod 10)*50)+100;
         iy:=(i div 10)*30 ;
         if q[i]=2 then putimage(ix+50,iy,p2^,normalput);
         if q[i]=3 then putimage(ix+50,iy,p3^,normalput);
         if q[i]=4 then putimage(ix+50,iy,p4^,normalput);
         putimage(ix,iy,p1^,normalput);
         q[i]:=1;
         end;
   {--------------------spadek w lewo----------------}
{       if ol=0 then}
       if (q[i-1]=1) and (q[i+9]=1) and (i mod 10>0)then
         begin
         ol:=1;
         {q1[i+10]:=1;}
         q[i-1]:=q[i];
         ix:=((i mod 10)*50)+100;
         iy:=(i div 10)*30 ;
         if q[i]=2 then putimage(ix-50,iy,p2^,normalput);
         if q[i]=3 then putimage(ix-50,iy,p3^,normalput);
         if q[i]=4 then putimage(ix-50,iy,p4^,normalput);
         putimage(ix,iy,p1^,normalput);
         q[i]:=1;
         end;
     end;
     end;

     {---------------------kamien-----------------------}
     if kamien<0 then
     if q[i]=4 then
     if kam[i]=1 then { -> }
       if (q[i+1]=1)and(i mod 10<9)then
         begin
         kam[i]:=0;
         kam[i+1]:=1;
         q[i]:=1;
         q[i+1]:=4;
         ix:=((i mod 10)*50)+100;
         iy:=(i div 10)*30 ;
         putimage(ix+25,iy,p4^,normalput);
         putimage(ix+50,iy,p1^,normalput);
         putimage(ix,iy,p1^,normalput);
         putimage(ix+50,iy,p4^,normalput);
         kamien:=100;
         if q[i+2]=7 then koniec:=1;
         end;

      if kamien<0 then
      if q[i]=4 then
      if kam[i]=1 then { -> }
      if (q[i+1]=4)or (q[i+1]=3)or (q[i+1]=6)or(q[i+1]=2)and(i mod 10<9)and(q[i-1]=1)then
         begin
         kam[i]:=0;
         kam[i-1]:=2;
         q[i]:=1;
         q[i-1]:=4;
         ix:=((i mod 10)*50)+100;
         iy:=(i div 10)*30 ;
         putimage(ix-25,iy,p4^,normalput);
         putimage(ix-50,iy,p1^,normalput);
         putimage(ix,iy,p1^,normalput);
         putimage(ix-50,iy,p4^,normalput);
         if q[i+1]=2 then w[i+1]:=2;
         kamien:=100;
         end;

{      if kamien<0 then
      if q[i]=4 then
      if kam[i]=1 then
      if (q[i+1]=0)and(i mod 10<9)then
         begin
         kam[i]:=0;
         kam[i+1]:=2;
         q[i]:=1;
         q[i+1]:=4;
         ix:=((i mod 10)*50)+100;
         iy:=(i div 10)*30 ;
         putimage(ix+25,iy,p4^,normalput);
         putimage(ix+50,iy,p1^,normalput);
         putimage(ix,iy,p1^,normalput);
         putimage(ix+50,iy,p4^,normalput);

         kamien:=100;
         end;}

     if kamien<0 then
     if q[i]=4 then
     if kam[i]=2 then { <- }
       if (q[i-1]=1)and(i mod 10>0)then
         begin
         kam[i]:=0;
         kam[i-1]:=2;
         q[i]:=1;
         q[i-1]:=4;
         ix:=((i mod 10)*50)+100;
         iy:=(i div 10)*30 ;
         putimage(ix-25,iy,p4^,normalput);
         putimage(ix-50,iy,p1^,normalput);
         putimage(ix,iy,p1^,normalput);
         putimage(ix-50,iy,p4^,normalput);
         if q[i-2]=7 then koniec:=1;
         kamien:=100;
         end;

      if kamien<0 then
      if q[i]=4 then
      if kam[i]=2 then { <- }
      if (q[i-1]=4)or (q[i-1]=3)or (q[i-1]=6)or(q[i-1]=2)and(i mod 10>0)and(q[i+1]=1)then
         begin
         kam[i]:=0;
         kam[i+1]:=1;
         q[i]:=1;
         q[i+1]:=4;
         ix:=((i mod 10)*50)+100;
         iy:=(i div 10)*30 ;
         putimage(ix+25,iy,p4^,normalput);
         putimage(ix+50,iy,p1^,normalput);
         putimage(ix,iy,p1^,normalput);
         putimage(ix+50,iy,p4^,normalput);
         if q[i-1]=2 then w[i-1]:=2;
         kamien:=100;
         end;


end;{for}

for x:=0 to 1 do
for i:=0 to 99 do
if q[i]=7 then
     if z7=1 then begin
      if (z=#77)and(i mod 10<9) and (q[i+1]<>5)and(q[i+1]<>6) then
        begin    { --------->    -----------------------------------}
          if q[i+1]=3 then begin bonus:=bonus+10;diam:=diam+1;end;
          if (q[i+1]=2) or (q[i+1]=4)  then
          begin
            if (q[i+2]=1)and (i mod 10<8) then
              begin
              if q[i+3]=1 then kam[i+2]:=1;
              ix:=((i mod 10)*50)+100;
              iy:=(i div 10)*30 ;
              putimage(ix,iy,p1^,normalput);
              putimage(ix+0,iy,p_t1^,normalput);
              delay(5);
              putimage(ix+50,iy,p1^,normalput);
              if q[i+1]=2 then putimage(ix+100,iy,p2^,normalput);
              if q[i+1]=4 then putimage(ix+100,iy,p4^,normalput);

              putimage(ix,iy,p1^,normalput);
              putimage(ix+25,iy,p_t2^,normalput);
              delay(50);
              putimage(ix,iy,p1^,normalput);
              putimage(ix+50,iy,p_t1^,normalput);
              delay(50);
              putimage(ix+50,iy,p7^,normalput);
{              putimage(ix,iy,p1^,normalput);
             { putimage(ix+50,iy,p7^,normalput);
              putimage(ix,iy,p1^,normalput);}
{              if q[i+1]=2 then putimage(ix+100,iy,p2^,normalput);
              if q[i+1]=4 then putimage(ix+100,iy,p4^,normalput);}
              {putimage(ix,iy,p1^,normalput);}
              q[i]:=1;
              q[i+2]:=q[i+1];
              q[i+1]:=7;
              qz:=q[i+1];
             end;
          end
          else
            begin
            ix:=((i mod 10)*50)+100;
              iy:=(i div 10)*30 ;

              putimage(ix,iy,p1^,normalput);
              putimage(ix+0,iy,p_t1^,normalput);
              delay(50);
              putimage(ix,iy,p1^,normalput);
              putimage(ix+25,iy,p_t2^,normalput);
              delay(50);
              putimage(ix,iy,p1^,normalput);
              putimage(ix+50,iy,p_t1^,normalput);
              delay(50);
              putimage(ix+50,iy,p7^,normalput);
{              putimage(ix,iy,p1^,normalput);}
{              putimage(ix+50,iy,p7^,normalput);
              putimage(ix,iy,p1^,normalput);}
              q[i]:=1;
              q[i+1]:=7;
              qz:=q[i+1];
              end;
        end;
      if(z=#75)and(i mod 10 >0) and (q[i-1]<>5)and(q[i-1]<>6)then
       {  <----         -------------------------------------------------}
        begin
         if q[i-1]=3 then begin bonus:=bonus+10;diam:=diam+1;end;
         if (q[i-1]=2) or (q[i-1]=4) then
          begin
            if (q[i-2]=1)and (i mod 10>1) then
              begin
              if q[i-3]=1 then kam[i-2]:=2;
              if q[i+1]=4 then kam[i+1]:=1;
              ix:=((i mod 10)*50)+100;
              iy:=(i div 10)*30 ;
              {
              if q[i+1]=2 then putimage(ix+100,iy,p2^,normalput);
              if q[i+1]=4 then putimage(ix+100,iy,p4^,normalput);

              }
              putimage(ix,iy,p1^,normalput);
              putimage(ix+0,iy,p_t1^,normalput);
              delay(50);
              putimage(ix-50,iy,p1^,normalput);
              if q[i-1]=2 then putimage(ix-100,iy,p2^,normalput);
              if q[i-1]=4 then putimage(ix-100,iy,p4^,normalput);
              putimage(ix,iy,p1^,normalput);
              putimage(ix-25,iy,p_t2^,normalput);
              delay(50);
              putimage(ix,iy,p1^,normalput);
              putimage(ix-50,iy,p_t1^,normalput);
              delay(50);
              putimage(ix-50,iy,p7^,normalput);
              q[i]:=1;
              q[i-2]:=q[i-1];
              q[i-1]:=7;
              qz:=q[i-1];
             end;
          end
          else
            begin
            ix:=((i mod 10)*50)+100;
              iy:=(i div 10)*30 ;
              putimage(ix,iy,p1^,normalput);
              putimage(ix+0,iy,p_t1^,normalput);
              delay(50);
              putimage(ix,iy,p1^,normalput);
              putimage(ix-25,iy,p_t2^,normalput);
              delay(50);
              putimage(ix,iy,p1^,normalput);
              putimage(ix-50,iy,p_t1^,normalput);
              delay(50);
              putimage(ix-50,iy,p7^,normalput);
{              putimage(ix-50,iy,p7^,normalput);
              putimage(ix,iy,p1^,normalput);   }
              q[i]:=1;
              q[i-1]:=7;
              qz:=q[i-1];
              end;
        end;{lewo}
      if(z=#72)and(i>9)and(q[i-10]<>4)and(q[i-10]<>2) and(q[i-10]<>5)and(q[i-10]<>6) then
      {gora}
        begin
         if q[i-10]=3 then begin bonus:=bonus+10;diam:=diam+1;end;
         q[i]:=1;
         q[i-10]:=7;
         qz:=q[i-10];
         ix:=((i mod 10)*50)+100;
         iy:=(i div 10)*30 ;

         {putimage(ix,iy,p1^,normalput);
         putimage(ix,iy-10,p_n1^,normalput);
         delay(60);
         putimage(ix,iy,p1^,normalput);
         putimage(ix,iy-15,p7^,normalput);
         delay(60);
         putimage(ix,iy,p1^,normalput);
         putimage(ix,iy-20,p_n2^,normalput);
         delay(60);
         putimage(ix,iy-30,p7^,normalput);
         putimage(ix,iy,p1^,normalput);}
         putimage(ix,iy,p1^,normalput);
              putimage(ix,iy,p_t1^,normalput);
              delay(50);
              putimage(ix,iy,p1^,normalput);
              putimage(ix,iy-15,p_t2^,normalput);
              delay(50);
              putimage(ix,iy,p1^,normalput);
              putimage(ix,iy-30,p_t1^,normalput);
              delay(50);
              putimage(ix,iy-30,p7^,normalput);
        end;
      if(z=#80)and(i<90)and(q[i+10]<>4)and(q[i+10]<>2) and(q[i+10]<>5)and(q[i+10]<>6)  then
      {dol}
        begin
        if q[i+10]=3 then begin bonus:=bonus+10;diam:=diam+1;end;
         q[i]:=1;
         q[i+10]:=7;
         qz:=q[i+10];
         ix:=((i mod 10)*50)+100;
         iy:=(i div 10)*30 ;
         putimage(ix,iy,p1^,normalput);
              putimage(ix,iy,p_t1^,normalput);
              delay(50);
              putimage(ix,iy,p1^,normalput);
              putimage(ix,iy+15,p_t2^,normalput);
              delay(50);
              putimage(ix,iy,p1^,normalput);
              putimage(ix,iy+30,p_t1^,normalput);
              delay(50);
              putimage(ix,iy+30,p7^,normalput);
{         putimage(ix,iy,p1^,normalput);
         putimage(ix,iy+10,p_n1^,normalput);
         delay(60);
         putimage(ix,iy,p1^,normalput);
         putimage(ix,iy+15,p7^,normalput);
         delay(60);
         putimage(ix,iy,p1^,normalput);
         putimage(ix,iy+20,p_n2^,normalput);
         delay(60);
         putimage(ix,iy+30,p7^,normalput);
         putimage(ix,iy,p1^,normalput);}
{         putimage(ix,iy+30,p7^,normalput);
         putimage(ix,iy,p1^,normalput);}

        end;
      z7:=0;



end;


setfillstyle(1,red);
if koniec=1 then begin for i:=1000 downto 0 do
  begin
    sound(i);
    delay(1);
  end;
  nosound;{sound(100);delay(50);NoSound;MSt_Load('BUZI_A',400-100,150-70);delay(1000);MSt_load('szczek_a',300,80)}
 od_nowa:=1;delay(100); goto next;end;

if (q[wyjscie]=7) and (diam=diamenty) then
begin
  etap:=etap+1;
  dobrze:=true;
  mst:=13;
  goto next;
end;
if q[wyjscie]=7 then
begin
         i:=wyjscie;
         ix:=((i mod 10)*50)+100;
         iy:=(i div 10)*30 ;
         putimage(ix,iy,p10^,normalput);
         q[i]:=8;

end;

if bonus1<>bonus then
begin
{  if bonus1<bonus then
  if random(2)=0 then
  for i:=10 downto 0 do
  begin
    sound(i*100);
    delay(50);
  end
  else
  for i:=1000 downto 0 do
  begin
    sound(i);
    delay(1);
  end;
  nosound;}

  setcolor(8);
    {OutTextXY(0,100,' Punkty:');}
  str(bonus,bon);
  setfillstyle(1,7);
  bar(20,110,65,117);
  OutTextXY(20,110,bon);
  OutTextXY(21,110,bon);
  bonus1:=bonus;


end;
if z=#68 then czyf10:=true;
if z=#27 then koniec:=1;
until z=#68;
theend:=1;
next:
cleardevice;

if dobrze=false then begin
MSt_odczyt('tasman','buzi_a',320-35,200-80);delay(1000);MSt_odczyt('tasman','szczek_a',320-35,200-80);
delay(1000);
end;
{dobrze:=false;}

z:='+';


end;

{-------------------------edytor---------------------------------------}
procedure edytor;
label end_edytor,etap_l,nr_etapu,edytor,grala,zly_kod;
begin
for i:=0 to 100 do q[i]:=0;
edytor:
pocz:=0;
ix:=100;iy:=0;x:=100;y:=100;
SetActivePage(1);
ClearDevice;
    tlo_(15,8,7,2,2,72,300,0);

    setcolor(brown);
    SetTextStyle(11,0,4);
    e_c:=32;
    e_ix:=10+5;e_iy:=0+5;
    OutTextXY(3,e_iy,'1');
    putimage(e_ix,e_iy,p1^,normalput);
    e_iy:=e_iy+e_c;
    OutTextXY(3,e_iy,'2');
    putimage(e_ix,e_iy,p2^,normalput);
    e_iy:=e_iy+e_c;
    OutTextXY(3,e_iy,'3');
    putimage(e_ix,e_iy,p3^,normalput);
    e_iy:=e_iy+e_c;
    OutTextXY(3,e_iy,'4');
    putimage(e_ix,e_iy,p4^,normalput);
    e_iy:=e_iy+e_c;
    OutTextXY(3,e_iy,'5');
    putimage(e_ix,e_iy,p5^,normalput);
    e_iy:=e_iy+e_c;
    OutTextXY(3,e_iy,'6');
    putimage(e_ix,e_iy,p6^,normalput);
    e_iy:=e_iy+e_c;
    OutTextXY(3,e_iy,'7');
    putimage(e_ix,e_iy,p7^,normalput);
    e_iy:=e_iy+e_c;
    OutTextXY(3,e_iy,'8');
    putimage(e_ix,e_iy,p8^,normalput);
    e_iy:=e_iy+e_c;
    OutTextXY(3,e_iy,'9');
    putimage(e_ix,e_iy,p_n2^,normalput);

    {         if tlo1_2=1 then putimage(ix,iy,p^,normalput);
         if tlo1_2=0 then putimage(ix,iy,p_tr2^,normalput);
         if tlo1_2=2 then putimage(ix,iy,p_n2^,normalput);}
SetViewPort(0,10,getmaxx,getmaxy,clipoff);
tlo(85,-10,619,315);

for i:=0 to 99 do
  begin

    ix1:=ix+50;iy1:=iy+30;
    case q[i] of
      0:putimage(ix,iy,p_n2^,normalput);
      1:putimage(ix,iy,p1^,normalput);
      2:putimage(ix,iy,p2^,normalput);
      3:putimage(ix,iy,p3^,normalput);
      4:putimage(ix,iy,p4^,normalput);
      5:putimage(ix,iy,p5^,normalput);
      6:putimage(ix,iy,p6^,normalput);
      7:putimage(ix,iy,p7^,normalput);
      8:putimage(ix,iy,p8^,normalput);
    end;
    ix:=ix+50;
    if ix=600 then
      begin
       ix:=100;
       iy:=iy+30;
      end;
end;
SetTextStyle(15,0,3);
    tlo(0,getmaxy-14-15,318,getmaxy-15);
    OutTextXY(10,getmaxy-10-15,'F10-wyjscie    Alt+Z-zachowaj plansze  ');
    setcolor(red);
    OutTextXY(10,getmaxy-10-15,'F10            Alt+Z                   ');


   { Assign(level1,'c:\MST\level.pas');
    append(level1);
    filepoz:=FilePos(level1);
    Close(level1);
    Str(filepoz,tekst);
    OutTextXY(0,0,tekst);}
qq:=0;
SetVisualPage(1);
repeat
ix:=100;iy:=0;x:=100;y:=100;
z:=readkey;


case z of

#80:if ii+10<=99 then ii:=ii+10;
#72:if ii-10>=0 then ii:=ii-10;
#77:if (ii+1<=99) and (ii mod 10<>9)then ii:=ii+1;
#75:if (ii-1>=0) and (ii mod 10<>0)then ii:=ii-1;
{' ':qq:=qq+1;}
'1':qq:=1;
'2':qq:=2;
'3':qq:=3;
'4':qq:=4;
'5':qq:=5;
'6':qq:=6;
'7':qq:=7;
'8':qq:=8;
'9':qq:=0;
' ':tak:=true;
end;
if qq=9 then qq:=0;
{if ii>99 then ii:=99;
if ii0 then ii:=0;}


for i:=0 to 99 do
  begin

    ix1:=ix+50;iy1:=iy+30;
    if i=ii then
    begin

    case qq of
      0:putimage(ix,iy,p_n2^,normalput);
      1:putimage(ix,iy,p1^,normalput);
      2:putimage(ix,iy,p2^,normalput);
      3:putimage(ix,iy,p3^,normalput);
      4:putimage(ix,iy,p4^,normalput);
      5:putimage(ix,iy,p5^,normalput);
      6:putimage(ix,iy,p6^,normalput);
      7:putimage(ix,iy,p7^,normalput);
      8:putimage(ix,iy,p8^,normalput);
    end;
        SetColor(brown);
    Rectangle(ix,iy,ix+49,iy+29);
    setcolor(0);
    Rectangle(ix+1,iy+1,ix+48,iy+28);
    end;
    if (i=ii) and (tak) then
    begin
    q[i]:=qq;
    if i=ii then
    case q[i] of
      0:putimage(ix,iy,p_n2^,normalput);

      1:putimage(ix,iy,p1^,normalput);
      2:putimage(ix,iy,p2^,normalput);
      3:putimage(ix,iy,p3^,normalput);
      4:putimage(ix,iy,p4^,normalput);
      5:putimage(ix,iy,p5^,normalput);
      6:putimage(ix,iy,p6^,normalput);
      7:putimage(ix,iy,p7^,normalput);
      8:putimage(ix,iy,p8^,normalput);
    end;
    end;
    if (i=ii-1) then
    case q[i] of
      0:putimage(ix,iy,p_n2^,normalput);

      1:putimage(ix,iy,p1^,normalput);
      2:putimage(ix,iy,p2^,normalput);
      3:putimage(ix,iy,p3^,normalput);
      4:putimage(ix,iy,p4^,normalput);
      5:putimage(ix,iy,p5^,normalput);
      6:putimage(ix,iy,p6^,normalput);
      7:putimage(ix,iy,p7^,normalput);
      8:putimage(ix,iy,p8^,normalput);
    end;
    if (i=ii+1) then
    case q[i] of
      0:putimage(ix,iy,p_n2^,normalput);

      1:putimage(ix,iy,p1^,normalput);
      2:putimage(ix,iy,p2^,normalput);
      3:putimage(ix,iy,p3^,normalput);
      4:putimage(ix,iy,p4^,normalput);
      5:putimage(ix,iy,p5^,normalput);
      6:putimage(ix,iy,p6^,normalput);
      7:putimage(ix,iy,p7^,normalput);
      8:putimage(ix,iy,p8^,normalput);
    end;
    if (i=ii+10) then
    case q[i] of
      0:putimage(ix,iy,p_n2^,normalput);

      1:putimage(ix,iy,p1^,normalput);
      2:putimage(ix,iy,p2^,normalput);
      3:putimage(ix,iy,p3^,normalput);
      4:putimage(ix,iy,p4^,normalput);
      5:putimage(ix,iy,p5^,normalput);
      6:putimage(ix,iy,p6^,normalput);
      7:putimage(ix,iy,p7^,normalput);
      8:putimage(ix,iy,p8^,normalput);
    end;
    if (i=ii-10) then
    case q[i] of
      0:putimage(ix,iy,p_n2^,normalput);

      1:putimage(ix,iy,p1^,normalput);
      2:putimage(ix,iy,p2^,normalput);
      3:putimage(ix,iy,p3^,normalput);
      4:putimage(ix,iy,p4^,normalput);
      5:putimage(ix,iy,p5^,normalput);
      6:putimage(ix,iy,p6^,normalput);
      7:putimage(ix,iy,p7^,normalput);
      8:putimage(ix,iy,p8^,normalput);
    end;
    ix:=ix+50;
    if ix=600 then
      begin
       ix:=100;
       iy:=iy+30;
      end;
    if i<>99 then begin
    {SetColor(0);
    line(ix,iy,ix+50,iy+30);
    line(ix+50,iy,ix,iy+30);}
    end;
end;

tak:=false;
until (z=#68) or (z=#44);
  if z=#68 then goto end_edytor;

  sp:=100;
  sp1:=100;
  For i:=0 to 99 do
  begin
  if q[i]=7 then sp:=300;
  if q[i]=8 then sp1:=300;
  end;
  setcolor(0);
  if (sp=100) or (sp1=100)              then begin
                                         setactivepage(0);
                                         cleardevice;
                                         setvisualpage(0);

                                         tlo_(15,8,3,3,3,395,25,1);
                                         OutTextXY(10,10,'Nie ma "tasmana" lub "drogi ewakuacyjnej" !!!') ;
                                         delay(2000);
                                         goto edytor;
                                         end;

          nr_etapu:
{          ClearDevice;

          SetViewPort(0,0,getmaxx,getmaxy,clipon);}
          Tlo_(15,8,3,100+100,100,350+100,130,1);
          SetColor(0);
          SetTextStyle(11,0,red);
          OutTextXY(120+100,110,'Podaj opoznienie (3 znaki):');
          SetColor(0);
          SetFillStyle(1,3);
          etap_txt:='';
          z:=readkey;
          etap_txt:=etap_txt+z;
          Bar(150+150,120,170+150,130);
          OutTextXY(150+150,120,etap_txt);

          z:=readkey;
          etap_txt:=etap_txt+z;
          Bar(150+150,120,170+150,130);

          OutTextXY(150+150,120,etap_txt);
          z:=readkey;
          etap_txt:=etap_txt+z;
          Bar(150+150,120,170+150,130);
          OutTextXY(150+150,120,etap_txt);

          Val(etap_txt,sp_etap,blad_val);
          if (sp_etap<1) or (sp_etap>10000) then goto nr_etapu;

                     zly_kod:
                     Tlo_(7,8,brown,100+100,100,350+100,130,1);
                     SetColor(0);
                     SetTextStyle(11,0,0);
                     OutTextXY(120+100-15,110,'Nadaj kod planszy (7 znakow):');
                     SetColor(0);
                     SetFillStyle(1,brown);
                     kode:='';
                     for i:=0 to 6 do
                     begin
                       repeat
                        z:=readkey;
                        Z:=UpCase(z);
                       until(z='Q')or(z='W')or(z='E')or(z='R')or(z='T')or(z='Y')or(z='U')or(z='I')or(z='O')or(z='P')or(z='A')
                            or(z='S')or(z='D')or(z='F')or(z='G')or(z='H')or(z='J')or(z='K')or(z='L')or(z='Z')or(z='X')or(z='C')
                            or(z='V')or(z='B')or(z='N')or(z='M')or(z='.');
                        kode:=kode+z;
{                        Bar(150+150,120,170+150,130);}
                        OutTextXY(150+150-10,120,kode);
                     end;

                     Assign(plik,'tasman.etp');
                     Reset(plik);
                     repeat
                     read(plik,etapy);
                     until (eof(plik)) or (kode=etapy.kod);
                     close(plik);
                     if (kode=etapy.kod) then goto zly_kod;




{  ed:=q;}
for i:=0 to 100 do ed[i]:=q[i];
  spowolnienie:=sp_etap;
  etap:=l_pl;

grala:
{for i:=0 to 99 do q[i]:=0;}
for i:=0 to 99 do q1[i]:=0;
for i:=0 to 99 do zg[i]:=0;
for i:=0 to 99 do w[i]:=0;
for i:=0 to 99 do kam[i]:=0;
diam:=0;
sekkk:=0;


setactivepage(0);
cleardevice;
tlo(0,170,70,270);
SetTextStyle(8,1,5);
SetColor(8);
OutTextXY(10-9,180-5-5,'Test');
SetColor(8);
OutTextXY(11-9,180-5-5,'Test');
SetColor(8);
OutTextXY(11-9,181-5-5,'Test');
SetColor(0);
OutTextXY(10-9,181-5-5,'Test');
SetTextStyle(20,0,1);
theend:=0;
dobrze:=false;


  czyf10:=false;
  edytorr:=true;
  gra;
  edytorr:=false;
  for i:=0 to 100 do q[i]:=ed[i];
  if czyf10=true then goto edytor;
  if dobrze=false then goto grala;

{  goto start;}

 {           SetViewPort(0,0,getmaxx,getmaxy,clipon);
            zly_kod:
  oile:=84;
  setfillstyle(0,0);

  Tlo_(7,8,brown,100,100+oile+25,350,200+oile-20+1,1);
  Tlo1(131,151+oile,308,170+oile,0,8,7);

  SetColor(0);
  SetTextStyle(11,0,red);
  OutTextXY(120-7,110+oile+25,'Podaj kod planszy(max 7 zn.):');
  TextColor(3);
  TextBackground(0);
  Window(18,12+6,38,12+6);
  GotoXY(1,1);
  readln(kode);
  Assign(plik,'tasman.etp');
  Reset(plik);
  repeat
  read(plik,etapy);
  until (eof(plik)) or (kode=etapy.kod);
  if (kode=etapy.kod) or (kode=' ') or (kode='')then goto zly_kod;
  close(plik);

  }
{  begin
    cleardevice;
    outtextxy(0,0);}



  cleardevice;
  tlo_(7,8,brown,5,5,500,25,1);
  SetColor(0);
OutTextXY(12,12,'Czy dolaczyc utworzony etap do istniejacych ?  (T-tak,N-nie)');
repeat
z:=readkey;
z:=upcase(z);
until (z='T') or (z='N');
if z='N' then goto edytor;


  Assign(plik,'tasman.etp');
  Reset(plik);
  Repeat
    read(plik,etapy);
  until eof(plik);


{  append(level);
  For i:=0 to 9 do
  begin
  for i1:=0 to 9 do
  Write(level,q[(i*10)+i1],' ');
  write(level,' ');
  Writeln(level,sp_etap);
  end;
  writeln(level,' ');}
  for i:=0 to 101 do etapy.q[i]:=q[i];{poprawicccccccccccccccccccccccccccccccccccc}
  etapy.spowolnienie:=sp_etap;
  etapy.kod:=kode;
  etapy.nr:=l_PL+1;
  write(plik,etapy);
  close(plik);

  ClearDevice;
  SetColor(7);

OutTextXY(0,0,'Etap zostal zapisany na dysk ...');
delay(2000);
  end_edytor:

end;


{bbbbbbbbbbbbbbbbbbbbbbbbbeeeeeeeeeeeeeeeeeeeeeegggggggggggggiiiiiiiiiiiiinnnnn}
begin
{Vgainit;}
    sterownik:=vga;
    tryb:=vgamed;
    initgraph(sterownik,tryb,'c:\tp\bgi');
    tlo_(7,8,brown,5,5,160,22,1);
    setcolor(0);
    OutTextXY(10,10,'Poczekaj chwile...');
    OutTextXY(1+10,2+10,'              ,   ');
    SetActivePage(1);
    SetVisualPage(0);


mst_load('tas',0,0);
xx:=0;yy:=0;aa:=51;
size:=ImageSize(xx,yy,xx+50,yy+30);
GetMem(p,size);
GetImage(xx,yy,xx+50,yy+30,p^);
xy;
{MSt_odczyt('tasman','traw_a2',0,0);}
size_tr2:=ImageSize(xx,yy,xx+50,yy+30);
GetMem(p_tr2,size_tr2);
GetImage(xx,yy,xx+51,yy+30,p_tr2^);
xy;
{MSt_odczyt('tasman','traw_a',0,0);}
size_n2:=ImageSize(xx,yy,xx+50,yy+30);
GetMem(p_n2,size_n2);
GetImage(xx,yy,xx+50,yy+30,p_n2^);
xy;
{nic-1}
SetFillStyle(1,8);
bar(0,0,50,30);
setcolor(13);
size1:=ImageSize(0,0,50,30);
GetMem(p1,size1);
GetImage(0,0,50,30,p1^);
{MSt_odczyt('tasman','nitr_o',0,0);}
size2:=ImageSize(xx,yy,xx+50,yy+30);
GetMem(p2,size2);
GetImage(xx,yy,xx+50,yy+30,p2^);
xy;
{MST_odczyt('tasman','scor_e',0,0);}
size3:=ImageSize(xx,yy,xx+50,yy+30);
GetMem(p3,size3);
GetImage(xx,yy,xx+50,yy+30,p3^);
xy;
{MSt_odczyt('tasman','kamie_n',0,0);}
size4:=ImageSize(xx,yy,xx+50,yy+30);
GetMem(p4,size4);
GetImage(xx,yy,xx+50,yy+30,p4^);
xy;
{MSt_odczyt('tasman','pl_ot',0,0);}
size5:=ImageSize(xx,yy,xx+50,yy+30);
GetMem(p5,size5);
GetImage(xx,yy,xx+50,yy+30,p5^);
xy;
{MSt_odczyt('tasman','mur_ek',0,0);}
size6:=ImageSize(xx,yy,xx+50,yy+30);
GetMem(p6,size6);
GetImage(xx,yy,xx+50,yy+30,p6^);
xy;
{mst_odczyt('tasman','mag_1',1,1);}
size7:=ImageSize(xx,yy,xx+50,yy+30);
GetMem(p7,size7);
GetImage(xx,yy,xx+50,yy+30,p7^);
xy;
{MSt_odczyt('tasman','exi_ttt',0,0);}
size8:=ImageSize(xx,yy,xx+50,yy+30);
GetMem(p8,size8);
GetImage(xx,yy,xx+50,yy+30,p8^);
xy;
{MSt_odczyt('tasman','bomb_a',0,0);}
size10:=ImageSize(xx,yy,xx+50,yy+30);
GetMem(p10,size8);
GetImage(xx,yy,xx+50,yy+30,p10^);
xy;
{mst_odczyt('tasman','tra1',1,1);}
size_t1:=ImageSize(xx,yy,xx+50,yy+30);
GetMem(p_t1,size_t1);
GetImage(xx,yy,xx+50,yy+30,p_t1^);
xy;
{mst_odczyt('tasman','tra2',1,1);}
size_t2:=ImageSize(xx,yy,xx+50,yy+30);
GetMem(p_t2,size_t2);
GetImage(xx,yy,xx+50,yy+30,p_t2^);
xy;
{MSt_odczyt('tasman','traba1',0,0);}
size_tra1:=ImageSize(xx,yy,xx+50,yy+30);
GetMem(p_tra1,size_tra1);
GetImage(xx,yy,xx+50,yy+30,p_tra1^);
{MSt_odczyt('tasman','traba2',0,0);}
size_tra2:=ImageSize(90,62,90+50,62+30);
GetMem(p_tra2,size_tra2);
GetImage(90,62,90+50,62+30,p_tra2^);
{    tytul_x:=-90;
    MSt_odczyt('tasman','tytul_t',100+tytul_x,60);
    MSt_odczyt('tasman','tytul_a',100+tytul_x+60,60);
    MSt_odczyt('tasman','tytul_s',100+tytul_x+120,60);
    MSt_odczyt('tasman','tytul_m',100+tytul_x+180,60);
    MSt_odczyt('tasman','tytul_aa',100+tytul_x+240,60);
    MSt_odczyt('tasman','tytul_n',100+tytul_x+300,60);
    MSt_odczyt('tasman','mst_ve_r',550,5);}
    size_tyt:=ImageSize(3*51,31,3*51+6*60+6,31+80+2);
    GetMem(p_tyt,size_tyt);
    GetImage(3*51,31,3*51+6*60+6,31+80+2,p_tyt^);
{    MSt_odczyt('tasman','mst_ve_r',550,5);}
    size_ver:=ImageSize(0,2*31,90,2*31+51);
    GetMem(p_ver,size_ver);
    GetImage(0,2*31,90,2*31+51,p_ver^);
    ole:

poczatek_gry:

ClearDevice;
pocz:=0;
edytorr:=false;


wolniej:=5;
bonus:=0;

for i:=100 to 109 do q[i]:=99;


koniec:=0;

theend:=0;
bonus2:=0;
bonus:=0;
sp:=160;
m:=0;
diam:=0;
sekkk:=0;
ii:=0;

{gra ............................................................................}
od_nowa:=1;


poczatek;
if pocz=3 then goto eenndd;
if pocz=2 then begin edytor;SetViewPort(0,0,getmaxx,getmaxy,clipon);assign(plik1,'tasman.etp');reset(plik1);
goto poczatek_gry;end;
nr_etapu:
{ClearDevice;}


  etap_O:=113;
etap_czy:=etap;



  SetViewPort(0,0,getmaxx,getmaxy,clipon);
  oile:=84;
{  setfillstyle(0,0);
  Bar(100,100+oile+25,350,200+oile-20+1);}
  settextstyle(12,0,12);
  i:=5;
  Tlo_(7,8,brown,100-5,100+oile+25,350+5,200+oile-20+1,1);
  i:=50;
  Tlo1(131+i,151+oile,308-i,170+oile,0,8,7);
  SetColor(0);
{  SetTextStyle(11,0,red);}
  OutTextXY(120-18-3,110+oile+25,'Podaj kod planszy,lub cyfre 1-9:');

{  TextColor(3);
  TextBackground(0);
  Window(18,12+6,38,12+6);
  GotoXY(1,1);
                    zly_kod:
                     Tlo_(7,8,brown,100+100,100,350+100,130,1);
                     SetColor(0);
                     SetTextStyle(11,0,0);
                     OutTextXY(120+100-15,110,'Nadaj kod planszy (7 znakow):');
                     SetColor(0);
                     SetFillStyle(1,brown);}
                     setcolor(3);
                     etap_txt:='';
                     for i:=0 to 6 do
                     begin
                       repeat
                        z:=readkey;
                        Z:=UpCase(z);
                        if (i=0) and ((z='1')or(z='2')or(z='3')or(z='4')or(z='5')or(z='6')or(z='7')or(z='8')or(z='9'))then
                              begin etap_txt:=z;goto start;end;
                       until(z='Q')or(z='W')or(z='E')or(z='R')or(z='T')or(z='Y')or(z='U')or(z='I')or(z='O')or(z='P')or(z='A')
                            or(z='S')or(z='D')or(z='F')or(z='G')or(z='H')or(z='J')or(z='K')or(z='L')or(z='Z')or(z='X')or(z='C')
                            or(z='V')or(z='B')or(z='N')or(z='M')or(z='.');
                        etap_txt:=etap_txt+z;

                        OutTextXY(120-18+50+40,110+oile+25+20+3,etap_txt);
                     end;

                     delay(300);


{  readln(etap_txt);}


{  Val(etap_txt,etap,blad_val);}
{  if (etap<1) or (etap>l_pl) then goto nr_etapu;}
{etap:=etap-1;
ClearDevice;  }

{goto eenndd;}
{etap:=1;}

start:
for i:=0 to 99 do q[i]:=0;
for i:=0 to 99 do q1[i]:=0;
for i:=0 to 99 do zg[i]:=0;
for i:=0 to 99 do w[i]:=0;
for i:=0 to 99 do kam[i]:=0;
diam:=0;
sekkk:=0;
{mst:=etap_txt;}
if etap_txt='1' then etap_txt:='AAAAAAAAAAAAAAAA';
if etap_txt='2' then etap_txt:='BBBBBBBBBBBBBBBB';
if etap_txt='3' then etap_txt:='CCCCCCCCCCCCCCCC';
if etap_txt='4' then etap_txt:='DDDDDDDDDDDDDDDD';
if etap_txt='5' then etap_txt:='EEEEEEEEEEEEEEEE';
if etap_txt='6' then etap_txt:='FFFFFFFFFFFFFFFF';
if etap_txt='7' then etap_txt:='GGGGGGGGGGGGGGGG';
if etap_txt='8' then etap_txt:='HHHHHHHHHHHHHHHH';
if etap_txt='9' then etap_txt:='IIIIIIIIIIIIIIII';

{  Assign(level,'level.mst');
  Reset(level);
/
  for i:=0 to etap*10 do readln(level,x);
  For i:=0 to 9 do
  begin
  for i1:=0 to 9 do
  Read(level,q[(i*10)+i1]);
  Readln(level,spowolnienie);
  end;
  Readln(level,x);
  close(level);}
{  etap_txt:='marcin';}

  if etap_O=113 then
  begin
     assign(plik1,'tasman.etp');
     reset(plik1);
     odczyt:=0;
     Repeat
       if eof(plik1) then begin close(plik1);goto nr_etapu;end;
       odczyt:=odczyt+1;
       read(plik1,etapy);
     until etapy.kod=etap_txt;
     cleardevice;
     close(plik1);
  end
  else
  begin
       odn:=0;
       Assign(plik1,'tasman.etp');
       reset(plik1);
       if mst=13 then odczyt:=odczyt+1;
       Repeat
         odn:=odn+1;
         if eof(plik1) then begin close(plik1);goto koniec_plansz;end;
         read(plik1,etapy);
       until odn=odczyt;
       close(plik1);

  end;


  ktora_plansza:=odczyt;
{        str(i,mst);
      if (i>0) and (i<10) then ktora_plansza:=i;}
  etap_O:=0;
  for i:=0 to 101 do q[i]:=etapy.q[i];
  spowolnienie:=etapy.spowolnienie;

  if od_nowa=0 then bonus2:=bonus
  else bonus:=bonus2;

od_nowa:=0;
etap_czy:=etap;
mst:=0;
gra;
if theend=1 then goto poczatek_gry;
goto start;

koniec_plansz:
    cleardevice;
    setcolor(7);
    OutTextXY(0,0,'Nie ma wiecej palnsz (sprobuj stworzyc kilka)...');
    delay(4500);
goto poczatek_gry;
eenndd:
SetVisualPage(0);
SetActivePage(1);
ClearDevice;
MSt_odczyt('tasman','konie_c',260,130);
SetVisualPage(1);
delay(500);
{repeat
until keypressed;}
z:=readkey;


FreeMem(p,size);
FreeMem(p1,size1);
FreeMem(p2,size2);
FreeMem(p3,size3);
FreeMem(p4,size4);
FreeMem(p5,size5);
FreeMem(p6,size6);
FreeMem(p7,size7);
FreeMem(p8,size8);
FreeMem(p10,size10);
FreeMem(p_n1,size_n1);
FreeMem(p_n2,size_n2);
FreeMem(p_t1,size_t1);
FreeMem(p_t2,size_t2);
FreeMem(p_tr2,size_tr2);
FreeMem(p_tra1,size_tra1);
FreeMem(p_tra2,size_tra2);
FreeMem(p_tyt,size_tyt);

CloseGraph;
GotoXY(10,0);
TextColor(14);
probny_end:
end.







{case z of
#72:y:=y-m;
#80:y:=y+m;
#75:x:=x-m;
#77:x:=x+m;
#71:begin x:=x-m;y:=y-m end;
#73:begin x:=x+m;y:=y-m end;
#79:begin x:=x-m;y:=y+m end;
#81:begin x:=x+m;y:=y+m end;
end;
end;}
{putimage(x,y,p2^,normalput);}
{if x<=1 then x:=x+m;
if x>=385 then x:=x-m;
if y<=5 then y:=y+m;
if y>=237 then y:=y-m;}