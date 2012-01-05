unit vermodul;
interface
uses dos,crt,graph;
const MouseInt = $33;

var
  regs : Registers;
  dk,t,t1,t2,t3,t4,theend,przycisk,nx,ny,i,barx,bary,bar1x,bar1y,mx,my,x,y,p,x1,y1,x2,y2:integer;
  pl,tura,koniec,w,cyfraI1,cyfraII1,cyfraI2,cyfraII2,size,poleI:word;
  pointe:pointer;
  c1txt,c2txt,tura1,czasm1,czasm2,czass1,czass2,itxt,Gracz1,gracz2:string[10];
  iint:real;
  del,los_g1,los_g2,st,gg1,gg2,cyfra1,cyfra2:word;
  g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g21,g22,g23,g24,g25,g26,g27,g28,g29,g30,g31,g32,g33:word;
  h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12,h13,h21,h22,h23,h24,h25,h26,h27,h28,h29,h30,h31,h32,h33:word;
  b:char;

  graczy:byte;
  ii,yy,xx:integer;
procedure vgainit;
var blad,sterownik,tryb:integer;

function MouseInit : boolean;

procedure MouseShow;

procedure MouseNot;

procedure MousePos(var x, y, p : Integer);

procedure tlo (nx,ny,mx,my:integer);

procedure tlo1 (nx,ny,mx,my,mn,mn1,mn2:integer);



Procedure koniecgry;
procedure poczatek;
procedure liczby_g1;
procedure liczby_g1a;
procedure v_grI;
procedure liczby_g2;
procedure liczby_g2a;
procedure v_grII;
{label cyfryII;}
{Label start,endtur,theend1,definitywnykoniec,gragraczII;}
implementation
procedure vgainit;
begin
  sterownik:=vga;
  tryb:=vgamed;
  initgraph (sterownik,tryb,'C:\TP\BGI');
  blad:=graphresult;
  if blad<>0 then
  begin
    writeln('Blad podczas inicjowania trybu graficznego');
    write ('Kod bledu : ',blad);
    halt
  end;
end;







function MouseInit;
begin
  regs.ax := $0;
  intr(MouseInt,regs);
  if regs.ax = $ffff then
      MouseInit := true
                     else
      MouseInit := false
end;

procedure MouseShow;
begin
  regs.ax := $1;
  intr(MouseInt,regs)
end;

procedure MouseNot;
begin
  regs.ax := $2;
  intr(MouseInt,regs)
end;

procedure MousePos;
begin
  regs.ax := $3;
  intr(MouseInt,regs);
  x:=regs.cx;
  y:=regs.dx;
  p:=regs.bx
end;

procedure tlo ;
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

procedure tlo1 ;
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





Procedure koniecgry;
begin
    MousePos(x,y,p);
    if (p=2) and (x>100+183) and (x<163+193) and (y>308+10) and (y<330+10) then st:=1;
    if (p=1) and (x>100+183) and (x<163+193) and (y>308+10) and (y<330+10) then
    begin
      SetViewPort(0,0,getmaxx,getmaxy,clipon);
      koniec:=1;
      MouseNot;
      tlo1(100+183,308+10,163+193,330+10,7,8,15);
      SetColor(15);
      SetTextStyle(2,0,6);
      OutTextXY(118+183,310+8,'wiem');
      OutTextXY(119+183,310+8,'wiem');
      Delay(100);
      repeat
        mousepos(x,y,p);
      until p=0;
      tlo(100+183,308+10,163+193,330+10);
      SetColor(8);
      SetTextStyle(2,0,6);
      OutTextXY(118+183,310+8,'wiem');
      OutTextXY(119+183,310+8,'wiem');
      SetActivePage(0);

      Cleardevice;
      SetVisualPage(0);
      x1:=150;y1:=100;
      SetTextStyle(9,0,3);
      for i:=0 to 9 do
      begin
        x2:=x1+73;y2:=y1+53;
        Tlo(x1,y1,x2-2,y2);
        str(i,itxt);
        OutTextXY(x1+25,y1+1,itxt);
        x1:=x1+80;
        if x1=400+150 then
        begin
          x1:=150;
          y1:=y1+60;
        end;
      end;
      SetColor(7);
      SetTextStyle(1,0,5);
      If pl=1 then OutTextXY(240,1,gracz1);
      If pl=2 then OutTextXY(240,1,gracz2);
      If pl=1 then gg1:=3;
      If pl=2 then gg2:=3;
      SetColor(7);
      SetTextStyle(5,0,5);
      OutTextXY(105,30,'Podaj liczbe:');
      OutTextXY(104,30,'Podaj liczbe:');
      SetTextStyle(10,0,10);
      SetColor(8);
      MouseShow;
      SetTextStyle(9,0,3);
      repeat
        MouseShow;
        MousePos(x,y,p);
        x1:=150;y1:=100;
        if p=1 then
        for i:=0 to 9 do
        begin
          x2:=x1+73;y2:=y1+53;
          if (x>x1) and (x<x2) and (y>y1) and (y<y2)  then
          begin
            MouseNot;
            cyfra1:=i;
            Tlo1(x1,y1,x2-2,y2,7,8,15);
            str(i,itxt);
            OutTextXY(x1+25,y1+1,itxt);
            Delay(300);
            Tlo(x1,y1,x2-2,y2);
            OutTextXY(x1+25,y1+1,itxt);
            MouseShow;
          end;
          x1:=x1+80;
          if x1=400+150 then
          begin
            x1:=150;
            y1:=y1+60;
          end;
        end;
      until cyfra1<>10;
      delay(100);

      repeat
        MouseShow;
        MousePos(x,y,p);
        x1:=150;y1:=100;
        for i:=0 to 9 do
        begin
          x2:=x1+73;y2:=y1+53;
          if p=1 then
          if (x>x1) and (x<x2) and (y>y1) and (y<y2)  then
          begin
            MouseNot;
            cyfra2:=i;
            Tlo1(x1,y1,x2-2,y2,7,8,15);
            str(i,itxt);
            OutTextXY(x1+25,y1+1,itxt);
            Delay(300);
            Tlo(x1,y1,x2-2,y2);
            OutTextXY(x1+25,y1+1,itxt);
            MouseShow;
          end;
          x1:=x1+80;
          if x1=400+150 then
          begin
            x1:=150;
            y1:=y1+60;
          end;
        end;
      until cyfra2<10;

      if pl=1 then
      begin

        if (cyfra1=cyfraII1) and (cyfra2=cyfraII2) then theend:=1;
        SetViewPort(1,1,310,330,clipoN);
      end;
      if pl=2 then
      begin

        if (cyfra1=cyfraI1) and (cyfra2=cyfraI2) then theend:=1;
        SetViewPort(332,1,630,330,clipon);
      end;
      MouseNot;
      SetActivePage(1);
      SetVisualPage(1);
    end;
end;
















procedure poczatek;
label poczatek;
begin
    poczatek:
    SetActivePage(1);
    ClearDevice;
    SetVisualPage(1);
    SetActivePage(0);
    SetViewPort(0,0,getMaxX,GetMaxY,clipon);
    tlo(0,0,getmaxx,getmaxy);
    SetViewPort(0+6,0+3,getMaxX-3,GetMaxY-3,clipon);
    xx:=-10;yy:=-17;
    for i:=0 to 310 do
    begin
    SetColor(8);
    OutTextXY(xx,yy,'VertigO');
    SetColor(red);
    OutTextXY(xx,yy,'V     O');
    xx:=xx+70;
    if xx>700 then begin
                   yy:=yy+15;
                   xx:=i-300;
                   end;
    end;
    SetFillStyle(1,7);
    bar(0,3,100,getmaxy-3);
    SetFillStyle(1,0);
{    bar(9,9,102,getmaxy-13);}
    tlo1(10,10,100,getmaxy-15,7,8,15);

    SetViewPort(0,0,getMaxX,GetMaxY,clipon);
    tlo(100+100,308,163+100,330);
    tlo1(50,50,550,200,3,15,8);
    SetColor(8);
    SetTextStyle(2,0,6);
    OutTextXY(110+100,308,'Start');
    OutTextXY(111+100,308,'Start');

    tlo(550,308,373+250,330);
    SetColor(8);
    SetTextStyle(2,0,6);
    OutTextXY(560,308,'Koniec');
    OutTextXY(561,308,'Koniec');

    tlo(550-100,308,373+250-80,330);
    SetColor(8);
    SetTextStyle(2,0,6);
    OutTextXY(560-100,308,'Graczy:2');
    OutTextXY(561-100,308,'Graczy:2');
    graczy:=2;

    tlo(550-100-130,308,373+250-80-100,330);
    SetColor(8);
    SetTextStyle(2,0,6);
    OutTextXY(560-100-125,308,'Informacja');
    OutTextXY(561-100-125,308,'Informacja');

    SetTextStyle(1,0,10);
    SetColor(15);
    OutTextXY(100-10,40,'VertigO');
    SetColor(8);
    OutTextXY(102-10,42,'VertigO');
    SetColor(0);
    OutTextXY(104-10,44,'VertigO');
    SetTextStyle(11,0,6);
    OutTextXY(100,180,' (C) MSt VertigO');
    OutTextXY(100,190,'Wisniew XI-XII.1994');
    OutTextXY(100,190-5,'  ,');
    przycisk:=0;
    SetVisualPage(0);
    if MouseInit then MouseShow;
    while przycisk<>1 do
    begin
      MousePos(x,y,p);
      if (p=1) and (x>100+100) and (x<163+100) and (y>308) and (y<330) then
      begin
        MouseNot;
        tlo1(100+100,308,160+100,330,7,8,15);
        SetColor(15);
        SetTextStyle(2,0,6);
        OutTextXY(110+100,308,'Start');
        OutTextXY(111+100,308,'Start');
        repeat
          mousepos(x,y,p);
        until p=0;
        tlo(100+100,308,163+100,330);
        SetColor(8);
        SetTextStyle(2,0,6);
        OutTextXY(110+100,308,'Start');
        OutTextXY(111+100,308,'Start');
        delay(500);
        przycisk:=1;
      end;
      MousePos(x,y,p);
      if (p=1) and (x>550) and (x<373+250) and (y>308) and (y<330) then
      begin
        dk:=123;
        przycisk:=1;
      end;

      if (p=1) and (x>550-100) and (x<373+250-80) and (y>308) and (y<330) then
      begin
        repeat
          mousepos(x,y,p);
        until p=0;
        MouseNot;
        if graczy=1 then graczy:=2
                    else graczy:=1;
        tlo(550-100,308,373+250-80,330);
        SetColor(8);
        SetTextStyle(2,0,6);
        if graczy=1 then
        begin
          OutTextXY(560-100,308,'Graczy:1');
          OutTextXY(561-100,308,'Graczy:1');
        end
        else
        begin
          OutTextXY(560-100,308,'Graczy:2');
          OutTextXY(561-100,308,'Graczy:2');
        end;
        MouseShow;
      end;
      {tlo(550-100-130,308,373+250-80-100,330);}
      if (p=1) and (x>550-230) and (x<373+250-180) and (y>308) and (y<330) then
      begin
        repeat
          mousepos(x,y,p);
        until p=0;
        MouseNot;
        SetActivePage(1);
        ClearDevice;
        SetViewPort(0,0,getMaxX,getmaxy,clipon);
        tlo(0,0,getmaxx,150);
{        OutTextXy(10,10,'Instrukcja:');}
        SetTextStyle(12,0,12);
        SetColor(8);
        OutTextXy(10,10,'Po naciscieciu START i podaniu imienia wybierasz dwie liczby i wstawiasz je na ');
        OutTextXy(10,20,'pole pod ktorym widnieje imie twojego przeciwnika (gracz 2 robi to samo).' );
        OutTextXy(10,30,'Oczywiscie gdy wybierasz liczbe twoj przeciwnik musi na chwile odejsc od ');
        OutTextXy(10,40,'komputera.');
        OutTextXy(10,50,'Gdy wybierzesz "?" wtedy komputer wybierze losowo dwie cyfry i ustawi je na' );
        OutTextXy(10,60,'odpowiednim polu.');
        OutTextXy(10,70,'Jesli grasz w pojedynke liczbe ktora bedziesz odkrywal moze ci ktos wybrac lub ');
        OutTextXy(10,80,'mozesz wybrac ja losowo (?).');
        OutTextXy(10,90,'Musisz jak najszybciej dowiedziec sie jaka liczba (od 00 do 99) jest ukryta na');
        OutTextXy(10,100,'twojej planszy.');
        OutTextXy(10,110,'Gdy bedziesz to juz wiedzial kliknij lewym klawiszem myszy na "wiem" i podaj ');
        OutTextXy(10,120,'liczbe.');
        OutTextXy(10,135,'Uwaga: Klikniecie prawym klawiszem myszki na "wiem" konczy gre.');
        SetVisualPage(1);

        repeat
          mousepos(x,y,p);
        until p=1;
        repeat
          mousepos(x,y,p);
        until p=0;

        goto poczatek
      end;
    end;
end;




procedure liczby_g1;
begin
      if w>0 then
      begin
        if cyfraI1=1 then
        begin
          case i-w of
             2:Bar(barx,bary,bar1x,bar1y);
            11:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraI1=1 then
        begin
          case i-w of
            2:g1:=i;
            11:g2:=i;
            12:g3:=i;
            20:g4:=i;
            22:g5:=i;
            32:g6:=i;
            42:g7:=i;
          end;
        end;
        if cyfraI1=0 then
        begin
          case i-w of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            30:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraI1=0 then
        begin
          case i-w of
            1:g1:=i;
            2:g2:=i;
            10:g3:=i;
            12:g4:=i;
            20:g5:=i;
            22:g6:=i;
            30:g7:=i;
            32:g8:=i;
            40:g9:=i;
            41:g10:=i;
            42:g11:=i;
            0:g12:=i;
          end;
        end;
        if cyfraI1=2 then
        begin
          case i-w of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            30:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraI1=2 then
        begin
          case i-w of
            0:g1:=i;
            1:g2:=i;
            2:g3:=i;
            12:g4:=i;
            20:g5:=i;
            21:g6:=i;
            22:g7:=i;
            30:g8:=i;
            40:g9:=i;
            41:g10:=i;
            42:g11:=i;
          end;
        end;
        if cyfraI1=3 then
        begin
          case i-w of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraI1=3 then
        begin
          case i-w of
            0:g1:=i;
            1:g2:=i;
            2:g3:=i;
            12:g4:=i;
            20:g5:=i;
            21:g6:=i;
            22:g7:=i;
            32:g8:=i;
            40:g9:=i;
            41:g10:=i;
            42:g11:=i;
          end;
        end;
        if cyfraI1=4 then
        begin
          case i-w of
            0:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraI1=4 then
        begin
          case i-w of
            0:g1:=i;
            10:g2:=i;
            2:g3:=i;
            12:g4:=i;
            20:g5:=i;
            21:g6:=i;
            22:g7:=i;
            32:g8:=i;
            42:g9:=i;
          end;
        end;
        if cyfraI1=5 then
        begin
          case i-w of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraI1=5 then
        begin
          case i-w of
            0:g1:=i;
            1:g2:=i;
            2:g3:=i;
            10:g4:=i;
            20:g5:=i;
            21:g6:=i;
            22:g7:=i;
            32:g8:=i;
            40:g9:=i;
            41:g10:=i;
            42:g11:=i;
          end;
        end;
        if cyfraI1=6 then
        begin
          case i-w of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            30:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraI1=6 then
        begin
          case i-w of
            0:g1:=i;
            1:g2:=i;
            2:g3:=i;
            10:g4:=i;
            20:g5:=i;
            21:g6:=i;
            22:g7:=i;
            30:g8:=i;
            32:g12:=i;
            40:g9:=i;
            41:g10:=i;
            42:g11:=i;
          end;
        end;
        if cyfraI1=7 then
        begin
          case i-w of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraI1=7 then
        begin
          case i-w of
            0:g1:=i;
            1:g2:=i;
            2:g3:=i;
            12:g4:=i;
            22:g5:=i;
            32:g6:=i;
            42:g7:=i;
          end;
        end;
        if cyfraI1=8 then
        begin
          case i-w of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            30:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraI1=8 then
        begin
          case i-w of
            0:g1:=i;
            1:g2:=i;
            2:g3:=i;
            10:g4:=i;
            12:g5:=i;
            20:g6:=i;
            21:g7:=i;
            22:g8:=i;
            30:g9:=i;
            32:g10:=i;
            40:g11:=i;
            41:g12:=i;
            42:g13:=i;
          end;
        end;
        if cyfraI1=9 then
        begin
          case i-w of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraI1=9 then
        begin
          case i-w of
            0:g1:=i;
            1:g2:=i;
            2:g3:=i;
            10:g4:=i;
            12:g5:=i;
            20:g6:=i;
            21:g7:=i;
            22:g8:=i;
            32:g9:=i;
            40:g10:=i;
            41:g11:=i;
            42:g12:=i;
          end;
        end;


        if cyfraI2=1 then
        begin
          case i-w-4 of
             2:Bar(barx,bary,bar1x,bar1y);
            11:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraI2=1 then
        begin
          case i-w-4 of
            2:g21:=i;
            11:g22:=i;
            12:g23:=i;
            20:g24:=i;
            22:g25:=i;
            32:g26:=i;
            42:g27:=i;
          end;
        end;
        if cyfraI2=0 then
        begin
          case i-w-4 of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            30:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraI2=0 then
        begin
          case i-w-4 of
            1:g21:=i;
            2:g22:=i;
            10:g23:=i;
            12:g24:=i;
            20:g25:=i;
            22:g26:=i;
            30:g27:=i;
            32:g28:=i;
            40:g29:=i;
            41:g30:=i;
            42:g31:=i;
            0:g32:=i;
          end;
        end;
        if cyfraI2=2 then
        begin
          case i-w-4 of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            30:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraI2=2 then
        begin
          case i-w-4 of
            0:g21:=i;
            1:g22:=i;
            2:g23:=i;
            12:g24:=i;
            20:g25:=i;
            21:g26:=i;
            22:g27:=i;
            30:g28:=i;
            40:g29:=i;
            41:g30:=i;
            42:g31:=i;
          end;
        end;
        if cyfraI2=3 then
        begin
          case i-w-4 of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraI2=3 then
        begin
          case i-w-4 of
            0:g21:=i;
            1:g22:=i;
            2:g23:=i;
            12:g24:=i;
            20:g25:=i;
            21:g26:=i;
            22:g27:=i;
            32:g28:=i;
            40:g29:=i;
            41:g30:=i;
            42:g31:=i;
          end;
        end;
        if cyfraI2=4 then
        begin
          case i-w-4 of
            0:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraI2=4 then
        begin
          case i-w-4 of
            0:g21:=i;
            12:g22:=i;
            2:g23:=i;
            10:g24:=i;
            20:g25:=i;
            21:g26:=i;
            22:g27:=i;
            32:g28:=i;
            42:g29:=i;
          end;
        end;
        if cyfraI2=5 then
        begin
          case i-w-4 of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraI2=5 then
        begin
          case i-w-4 of
            0:g21:=i;
            1:g22:=i;
            2:g23:=i;
            10:g24:=i;
            20:g25:=i;
            21:g26:=i;
            22:g27:=i;
            32:g28:=i;
            40:g29:=i;
            41:g30:=i;
            42:g31:=i;
          end;
        end;
        if cyfraI2=6 then
        begin
          case i-w-4 of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            30:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraI2=6 then
        begin
          case i-w-4 of
            0:g21:=i;
            1:g22:=i;
            2:g23:=i;
            10:g24:=i;
            20:g25:=i;
            21:g26:=i;
            22:g27:=i;
            30:g28:=i;
            32:g32:=i;
            40:g29:=i;
            41:g30:=i;
            42:g31:=i;
          end;
        end;
        if cyfraI2=7 then
        begin
          case i-w-4 of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraI2=7 then
        begin
          case i-w-4 of
            0:g21:=i;
            1:g22:=i;
            2:g23:=i;
            12:g24:=i;
            22:g25:=i;
            32:g26:=i;
            42:g27:=i;
          end;
        end;
        if cyfraI2=8 then
        begin
          case i-w-4 of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            30:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraI2=8 then
        begin
          case i-w-4 of
            0:g21:=i;
            1:g22:=i;
            2:g23:=i;
            10:g24:=i;
            12:g25:=i;
            20:g26:=i;
            21:g27:=i;
            22:g28:=i;
            30:g29:=i;
            32:g30:=i;
            40:g31:=i;
            41:g32:=i;
            42:g33:=i;
          end;
        end;
        if cyfraI2=9 then
        begin
          case i-w-4 of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraI2=9 then
        begin
          case i-w-4 of
            0:g21:=i;
            1:g22:=i;
            2:g23:=i;
            10:g24:=i;
            12:g25:=i;
            20:g26:=i;
            21:g27:=i;
            22:g28:=i;
            32:g29:=i;
            40:g30:=i;
            41:g31:=i;
            42:g32:=i;
          end;
        end;
      end;
end;






procedure liczby_g1a;
begin
SetActivePage(1);
  ClearDevice;


  SetFillStyle(4,9);
  FloodFill(10,10,10);

  SetTextStyle(1,0,4);
  t1:=TextWidth(gracz1);
  t:=t1 div 2;
  Tlo(155-t-20,279,155+t+17,275+40);
  SetColor(1);
  OutTextXY(150-t,277,gracz1);

  t1:=TextWidth(gracz2);
  t:=t1 div 2;
  Tlo(490-t-20,279,490+t+17,275+40);
  SetColor(1);
  OutTextXY(490-t,277,gracz2);


  SetViewPort(1,1,310,330,clipoff);

  Tlo(20,1,285,265);


  SetFillStyle(1,0);
  barx:=28;bary:=8;
  for i:=1 to 100 do
  begin
    bar1x:=barx+23;bar1y:=bary+23;
    bar(barx,bary,bar1x,bar1y);
    barx:=barx+25;
    if barx=278 then
    begin
      barx:=28;
      bary:=bary+25;
    end;
  end;





  SetViewPort(332,1,630,330,clipon);

  tlo(20,1,285,265);

  setfillstyle(1,0);
    barx:=28;bary:=8;
    for i:=1 to 100 do
    begin
      bar1x:=barx+23;bar1y:=bary+23;
      bar(barx,bary,bar1x,bar1y);
      barx:=barx+25;
      if barx=278 then
      begin
        barx:=28;
        bary:=bary+25;
      end;
    end;


  SetVisualPage(1);

  SetViewPort(332,1,630,330,clipon);
  repeat
  w:=0;
  MouseShow;
  SetFillStyle(4,13);
  MousePos(x,y,p);
  x:=x-331;
  barx:=28;bary:=8;


    for i:=1 to 100 do
    begin
      iint:=(i/10)-(int(i/10));
      bar1x:=barx+23;bar1y:=bary+23;

      if (x>barx) and (x<bar1x) and (y>bary) and (y<bar1y) and (iint<0.5) and (i<55) then
      begin
        w:=i;
        MouseNot;
      end;
      if x>200  then w:=0;
      liczby_g1;
      barx:=barx+25;
      if barx=278 then
      begin
        barx:=28;
        bary:=bary+25;
      end;
    end;
    if w>0 then
    if p=1 then
      begin
       w:=100;
       Delay(1000);
      end;
    setfillstyle(1,0);
    barx:=28;bary:=8;
    if w>0 then
    for i:=1 to 100 do
    begin
      bar1x:=barx+23;bar1y:=bary+23;
      bar(barx,bary,bar1x,bar1y);
      barx:=barx+25;
      if barx=278 then
      begin
        barx:=28;
        bary:=bary+25;
      end;
    end;

  until w=100;
end;




procedure v_grI;
label cyfry;
begin;

  if graczy=2 then
  begin
  ClearDevice;
  Tlo1(100,100,350,200,3,15,8);
  Tlo1(131,151,308,170,0,8,15);
  SetColor(0);
  SetTextStyle(11,0,3);
  OutTextXY(120,110,'Graczu I podaj swoje imie:');
  TextColor(7);
  TextBackground(0);
  Window(18,12,38,12);
  GotoXY(1,1);
  readln(gracz1);
  end;

  ClearDevice;
  Tlo1(100,100,350,200,3,15,8);
  Tlo1(131,151,308,170,0,8,15);
  SetColor(0);
  SetTextStyle(11,0,3);
  if graczy=1 then OutTextXY(120,110,'Graczu podaj swoje imie:')
              else  OutTextXY(120,110,'Graczu II podaj swoje imie:');
  TextColor(7);
  TextBackground(0);
  Window(18,12,38,12);
  GotoXY(1,1);
  readln(gracz2);

  ClearDevice;
  x1:=150;y1:=100;
  SetTextStyle(9,0,3);
  for i:=0 to 10 do
  begin
    x2:=x1+73;y2:=y1+53;
    Tlo(x1,y1,x2-2,y2);
    str(i,itxt);
    if i<>10 then  OutTextXY(x1+25,y1+1,itxt);
    if i=10 then OutTextXY(x1+25,y1+1,'?');
    x1:=x1+80;
    if x1=400+150 then
    begin
      x1:=150;
      y1:=y1+60;
    end;
  end;
  SetColor(7);
  SetTextStyle(1,0,5);
  OutTextXY(240,1,gracz1);
  OutTextXY(241,1,gracz1);
  SetColor(7);
  SetTextStyle(5,0,3);
  OutTextXY(105,60,'Wybierz liczbe i wstaw ja na pole przeciwnika');
  OutTextXY(106,60,'Wybierz liczbe i wstaw ja na pole przeciwnika');
  SetTextStyle(10,0,10);
  SetColor(8);
  OutTextXY(300,getmaxy-10,'Uwaga!!! Niech gracz II tego nie widzi !!!');
  SetViewPort(0,0,getmaxx,getmaxy,clipon);
  MouseShow;

  SetTextStyle(9,0,3);
repeat
  MousePos(x,y,p);
  x1:=150;y1:=100;
  if p=1 then
  for i:=0 to 10 do
  begin
  x2:=x1+73;y2:=y1+53;
    if (x>x1) and (x<x2) and (y>y1) and (y<y2)  then
    begin
      MouseNot;
      cyfraI1:=i;
      Tlo1(x1,y1,x2-2,y2,7,8,15);
      str(i,itxt);
      if i<>10 then  OutTextXY(x1+25,y1+1,itxt);
      if i=10 then OutTextXY(x1+25,y1+1,'?');
      Delay(300);
      Tlo1(x1,y1,x2-2,y2,7,15,8);
      if i<>10 then OutTextXY(x1+25,y1+1,itxt);
      if i=10 then OutTextXY(x1+25,y1+1,'?');
      MouseShow;
    end;
    x1:=x1+80;
    if x1=400+150 then
    begin
      x1:=150;
      y1:=y1+60;
    end;
  end;
  if cyfraI1=10 then
  begin
    cyfraI1:=(random(10));
    cyfraI2:=(random(10));
    los_g1:=1;
  end;
until cyfraI1<>100;
delay(100);
if cyfraI2=100 then
repeat
  MousePos(x,y,p);
  x1:=150;y1:=100;
  for i:=0 to 9 do
  begin
  x2:=x1+73;y2:=y1+53;
    if p=1 then
    if (x>x1) and (x<x2) and (y>y1) and (y<y2)  then
    begin
      MouseNot;
      cyfraI2:=i;
      Tlo1(x1,y1,x2-2,y2,7,8,15);
      str(i,itxt);
      OutTextXY(x1+25,y1+1,itxt);
      Delay(300);
      Tlo1(x1,y1,x2-2,y2,7,15,8);
      OutTextXY(x1+25,y1+1,itxt);
      MouseShow;
      end;
      x1:=x1+80;
      if x1=400+150 then
    begin
      x1:=150;
      y1:=y1+60;
    end;
  end;
until cyfraI2<10;
MouseNot;

if los_g1=1 then
begin
  w:=((random(4))+1)+((random(6)*10));
  for i:=w to 100 do
  liczby_g1;
end
else
 liczby_g1a;
end;

{ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo}



procedure liczby_g2;
begin
if w>0 then
      begin
        if cyfraII1=1 then
        begin
          case i-w of
             2:Bar(barx,bary,bar1x,bar1y);
            11:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraII1=1 then
        begin
          case i-w of
            2:h1:=i;
            11:h2:=i;
            12:h3:=i;
            20:h4:=i;
            22:h5:=i;
            32:h6:=i;
            42:h7:=i;
          end;
        end;
        if cyfraII1=0 then
        begin
          case i-w of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            30:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraII1=0 then
        begin
          case i-w of
            1:h1:=i;
            2:h2:=i;
            10:h3:=i;
            12:h4:=i;
            20:h5:=i;
            22:h6:=i;
            30:h7:=i;
            32:h8:=i;
            40:h9:=i;
            41:h10:=i;
            42:h11:=i;
            0:h12:=i;
          end;
        end;
        if cyfraII1=2 then
        begin
          case i-w of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            30:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraII1=2 then
        begin
          case i-w of
            0:h1:=i;
            1:h2:=i;
            2:h3:=i;
            12:h4:=i;
            20:h5:=i;
            21:h6:=i;
            22:h7:=i;
            30:h8:=i;
            40:h9:=i;
            41:h10:=i;
            42:h11:=i;
          end;
        end;
        if cyfraII1=3 then
        begin
          case i-w of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraII1=3 then
        begin
          case i-w of
            0:h1:=i;
            1:h2:=i;
            2:h3:=i;
            12:h4:=i;
            20:h5:=i;
            21:h6:=i;
            22:h7:=i;
            32:h8:=i;
            40:h9:=i;
            41:h10:=i;
            42:h11:=i;
          end;
        end;
        if cyfraII1=4 then
        begin
          case i-w of
            0:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraII1=4 then
        begin
          case i-w of
            0:h1:=i;
            12:h2:=i;
            2:h3:=i;
            10:h4:=i;
            20:h5:=i;
            21:h6:=i;
            22:h7:=i;
            32:h8:=i;
            42:h9:=i;
          end;
        end;
        if cyfraII1=5 then
        begin
          case i-w of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraII1=5 then
        begin
          case i-w of
            0:h1:=i;
            1:h2:=i;
            2:h3:=i;
            10:h4:=i;
            20:h5:=i;
            21:h6:=i;
            22:h7:=i;
            32:h8:=i;
            40:h9:=i;
            41:h10:=i;
            42:h11:=i;
          end;
        end;
        if cyfraII1=6 then
        begin
          case i-w of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            30:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraII1=6 then
        begin
          case i-w of
            0:h1:=i;
            1:h2:=i;
            2:h3:=i;
            10:h4:=i;
            20:h5:=i;
            21:h6:=i;
            22:h7:=i;
            30:h8:=i;
            32:h12:=i;
            40:h9:=i;
            41:h10:=i;
            42:h11:=i;
          end;
        end;
        if cyfraII1=7 then
        begin
          case i-w of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraII1=7 then
        begin
          case i-w of
            0:h1:=i;
            1:h2:=i;
            2:h3:=i;
            12:h4:=i;
            22:h5:=i;
            32:h6:=i;
            42:h7:=i;
          end;
        end;
        if cyfraII1=8 then
        begin
          case i-w of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            30:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraII1=8 then
        begin
          case i-w of
            0:h1:=i;
            1:h2:=i;
            2:h3:=i;
            10:h4:=i;
            12:h5:=i;
            20:h6:=i;
            21:h7:=i;
            22:h8:=i;
            30:h9:=i;
            32:h10:=i;
            40:h11:=i;
            41:h12:=i;
            42:h13:=i;
          end;
        end;
        if cyfraII1=9 then
        begin
          case i-w of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraII1=9 then
        begin
          case i-w of
            0:h1:=i;
            1:h2:=i;
            2:h3:=i;
            10:h4:=i;
            12:h5:=i;
            20:h6:=i;
            21:h7:=i;
            22:h8:=i;
            32:h9:=i;
            40:h10:=i;
            41:h11:=i;
            42:h12:=i;
          end;
        end;


        if cyfraII2=1 then
        begin
          case i-w-4 of
             2:Bar(barx,bary,bar1x,bar1y);
            11:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraII2=1 then
        begin
          case i-w-4 of
            2:h21:=i;
            11:h22:=i;
            12:h23:=i;
            20:h24:=i;
            22:h25:=i;
            32:h26:=i;
            42:h27:=i;
          end;
        end;
        if cyfraII2=0 then
        begin
          case i-w-4 of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            30:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraII2=0 then
        begin
          case i-w-4 of
            1:h21:=i;
            2:h22:=i;
            10:h23:=i;
            12:h24:=i;
            20:h25:=i;
            22:h26:=i;
            30:h27:=i;
            32:h28:=i;
            40:h29:=i;
            41:h30:=i;
            42:h31:=i;
            0:h32:=i;
          end;
        end;
        if cyfraII2=2 then
        begin
          case i-w-4 of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            30:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraII2=2 then
        begin
          case i-w-4 of
            0:h21:=i;
            1:h22:=i;
            2:h23:=i;
            12:h24:=i;
            20:h25:=i;
            21:h26:=i;
            22:h27:=i;
            30:h28:=i;
            40:h29:=i;
            41:h30:=i;
            42:h31:=i;
          end;
        end;
        if cyfraII2=3 then
        begin
          case i-w-4 of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraII2=3 then
        begin
          case i-w-4 of
            0:h21:=i;
            1:h22:=i;
            2:h23:=i;
            12:h24:=i;
            20:h25:=i;
            21:h26:=i;
            22:h27:=i;
            32:h28:=i;
            40:h29:=i;
            41:h30:=i;
            42:h31:=i;
          end;
        end;
        if cyfraII2=4 then
        begin
          case i-w-4 of
            0:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraII2=4 then
        begin
          case i-w-4 of
            0:h21:=i;
            12:h22:=i;
            2:h23:=i;
            10:h24:=i;
            20:h25:=i;
            21:h26:=i;
            22:h27:=i;
            32:h28:=i;
            42:h29:=i;
          end;
        end;
        if cyfraII2=5 then
        begin
          case i-w-4 of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraII2=5 then
        begin
          case i-w-4 of
            0:h21:=i;
            1:h22:=i;
            2:h23:=i;
            10:h24:=i;
            20:h25:=i;
            21:h26:=i;
            22:h27:=i;
            32:h28:=i;
            40:h29:=i;
            41:h30:=i;
            42:h31:=i;
          end;
        end;
        if cyfraII2=6 then
        begin
          case i-w-4 of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            30:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraII2=6 then
        begin
          case i-w-4 of
            0:h21:=i;
            1:h22:=i;
            2:h23:=i;
            10:h24:=i;
            20:h25:=i;
            21:h26:=i;
            22:h27:=i;
            30:h28:=i;
            32:h32:=i;
            40:h29:=i;
            41:h30:=i;
            42:h31:=i;
          end;
        end;
        if cyfraII2=7 then
        begin
          case i-w-4 of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraII2=7 then
        begin
          case i-w-4 of
            0:h21:=i;
            1:h22:=i;
            2:h23:=i;
            12:h24:=i;
            22:h25:=i;
            32:h26:=i;
            42:h27:=i;
          end;
        end;
        if cyfraII2=8 then
        begin
          case i-w-4 of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            30:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraII2=8 then
        begin
          case i-w-4 of
            0:h21:=i;
            1:h22:=i;
            2:h23:=i;
            10:h24:=i;
            12:h25:=i;
            20:h26:=i;
            21:h27:=i;
            22:h28:=i;
            30:h29:=i;
            32:h30:=i;
            40:h31:=i;
            41:h32:=i;
            42:h33:=i;
          end;
        end;
        if cyfraII2=9 then
        begin
          case i-w-4 of
            0:Bar(barx,bary,bar1x,bar1y);
            1:Bar(barx,bary,bar1x,bar1y);
            2:Bar(barx,bary,bar1x,bar1y);
            10:Bar(barx,bary,bar1x,bar1y);
            12:Bar(barx,bary,bar1x,bar1y);
            20:Bar(barx,bary,bar1x,bar1y);
            22:Bar(barx,bary,bar1x,bar1y);
            21:Bar(barx,bary,bar1x,bar1y);
            32:Bar(barx,bary,bar1x,bar1y);
            40:Bar(barx,bary,bar1x,bar1y);
            41:Bar(barx,bary,bar1x,bar1y);
            42:Bar(barx,bary,bar1x,bar1y);
          end;
        end;
        if cyfraII2=9 then
        begin
          case i-w-4 of
            0:h21:=i;
            1:h22:=i;
            2:h23:=i;
            10:h24:=i;
            12:h25:=i;
            20:h26:=i;
            21:h27:=i;
            22:h28:=i;
            32:h29:=i;
            40:h30:=i;
            41:h31:=i;
            42:h32:=i;
          end;
        end;
      end;
end;



procedure liczby_g2a;
begin;
{SetActivePage(1);
  ClearDevice;


  SetFillStyle(4,9);
  FloodFill(10,10,10);

  SetTextStyle(1,0,4);
  t1:=TextWidth(gracz1);
  t:=t1 div 2;
  Tlo(155-t-20,279,155+t+17,275+40);
  SetColor(1);
  OutTextXY(150-t,277,gracz1);

  t1:=TextWidth(gracz2);
  t:=t1 div 2;
  Tlo(490-t-20,279,490+t+17,275+40);
  SetColor(1);
  OutTextXY(490-t,277,gracz2);


  SetViewPort(1,1,310,330,clipoff);

  Tlo(20,1,285,265);}


  repeat
  w:=0;
  MouseShow;
  SetFillStyle(4,13);
  MousePos(x,y,p);
  barx:=28;bary:=8;


    for i:=1 to 100 do
    begin
      iint:=(i/10)-(int(i/10));
      bar1x:=barx+23;bar1y:=bary+23;

      if (x>barx) and (x<bar1x) and (y>bary) and (y<bar1y) and (iint<0.5) and (i<55) then
      begin
        w:=i;
        MouseNot;
      end;
      if x>200  then w:=0;
      liczby_g2;
      barx:=barx+25;
      if barx=278 then
      begin
        barx:=28;
        bary:=bary+25;
      end;
    end;
    if w>0 then
    if p=1 then
      begin
       w:=100;
       Delay(1000);
      end;
    setfillstyle(1,0);
    barx:=28;bary:=8;
    if w>0 then
    for i:=1 to 100 do
    begin
      bar1x:=barx+23;bar1y:=bary+23;
      bar(barx,bary,bar1x,bar1y);
      barx:=barx+25;
      if barx=278 then
      begin
        barx:=28;
        bary:=bary+25;
      end;
    end;
    if w=100 then delay (500);

  until w=100;
end;

procedure v_grII;
label cyfryII;
begin
  SetViewPort(0,0,getmaxx,getmaxy,clipon);
  SetActivePage(0);
  ClearDevice;
  SetVisualPage(0);
  SetTextStyle(2,0,5);
  ClearDevice;
  x1:=150;y1:=100;
  SetTextStyle(9,0,3);
  for i:=0 to 10 do
  begin
    x2:=x1+73;y2:=y1+53;
    Tlo(x1,y1,x2-2,y2);
    str(i,itxt);
    if i<>10 then OutTextXY(x1+25,y1+1,itxt);
    if i=10 then OutTextXY(x1+25,y1+1,'?');
    x1:=x1+80;
    if x1=400+150 then
    begin
      x1:=150;
      y1:=y1+60;
    end;
  end;
  SetColor(7);
  SetTextStyle(1,0,5);
  OutTextXY(240,1,gracz2);
  OutTextXY(241,1,gracz2);
  SetColor(7);
  SetTextStyle(5,0,3);
  OutTextXY(105,60,'Wybierz liczbe i wstaw ja na pole przeciwnika');
  OutTextXY(106,60,'Wybierz liczbe i wstaw ja na pole przeciwnika');
  SetTextStyle(10,0,10);
  SetColor(8);
  OutTextXY(300,getmaxy-10,'Uwaga!!! Niech gracz I tego nie widzi !!!');
  SetViewPort(0,0,getmaxx,getmaxy,clipon);

  SetTextStyle(9,0,3);
repeat
  MouseShow;
  MousePos(x,y,p);
  x1:=150;y1:=100;
  if p=1 then
  for i:=0 to 10 do
  begin
  x2:=x1+73;y2:=y1+53;
    if (x>x1) and (x<x2) and (y>y1) and (y<y2)  then
    begin
      MouseNot;
      cyfraII1:=i;
      Tlo1(x1,y1,x2-2,y2,7,8,15);
      str(i,itxt);
      if i<>10 then OutTextXY(x1+25,y1+1,itxt);
      if i=10 then OutTextXY(x1+25,y1+1,'?');
      Delay(300);
      Tlo(x1,y1,x2-2,y2);
      if i<>10 then OutTextXY(x1+25,y1+1,itxt);
      if i=10 then OutTextXY(x1+25,y1+1,'?');
      MouseShow;
    end;
    x1:=x1+80;
    if x1=400+150 then
    begin
      x1:=150;
      y1:=y1+60;
    end;
  end;
  if cyfraII1=10 then
  begin
    cyfraII1:=(random(10));
    cyfraII2:=(random(10));
    los_g2:=1;
  end;
until cyfraII1<>100;
delay(100);
if cyfraII2=100 then
repeat
  MousePos(x,y,p);
  x1:=150;y1:=100;
  for i:=0 to 9 do
  begin
  x2:=x1+73;y2:=y1+53;
    if p=1 then
    if (x>x1) and (x<x2) and (y>y1) and (y<y2)  then
    begin
      MouseNot;
      cyfraII2:=i;
      Tlo1(x1,y1,x2-2,y2,7,8,15);
      str(i,itxt);
      OutTextXY(x1+25,y1+1,itxt);
      Delay(300);
      Tlo(x1,y1,x2-2,y2);
      OutTextXY(x1+25,y1+1,itxt);
      MouseShow;
      end;
      x1:=x1+80;
      if x1=400+150 then
    begin
      x1:=150;
      y1:=y1+60;
    end;
  end;
until cyfraII2<100;


if los_g2=1 then
begin
{           mousenot;
           SetActivePage(1);
             ClearDevice;
             setViewPort(0,0,getmaxx,getmaxy,clipon);

             SetFillStyle(4,9);
             FloodFill(10,10,10);

             SetTextStyle(1,0,4);
             t1:=TextWidth(gracz1);
             t:=t1 div 2;
             Tlo(155-t-20,279,155+t+17,275+40);
             SetColor(1);
             OutTextXY(150-t,277,gracz1);

             t1:=TextWidth(gracz2);
             t:=t1 div 2;
             Tlo(490-t-20,279,490+t+17,275+40);
             SetColor(1);
             OutTextXY(490-t,277,gracz2);


             SetViewPort(1,1,310,330,clipoff);

             Tlo(20,1,285,265);


             SetFillStyle(1,0);
             barx:=28;bary:=8;
             for i:=1 to 100 do
             begin
               bar1x:=barx+23;bar1y:=bary+23;
               bar(barx,bary,bar1x,bar1y);
               barx:=barx+25;
               if barx=278 then
               begin
                 barx:=28;
                 bary:=bary+25;
               end;
             end;





             SetViewPort(332,1,630,330,clipon);

             tlo(20,1,285,265);

             setfillstyle(1,0);
               barx:=28;bary:=8;
               for i:=1 to 100 do
               begin
                 bar1x:=barx+23;bar1y:=bary+23;
                 bar(barx,bary,bar1x,bar1y);
                 barx:=barx+25;
                 if barx=278 then
                 begin
                   barx:=28;
                   bary:=bary+25;
                 end;
               end;


             SetVisualPage(1);

             SetViewPort(1,1,310,330,clipoN);}
  w:=((random(4))+1)+((random(6)*10));
  for i:=w to 100 do
  liczby_g2;
end;
if los_g2=10 then liczby_g2a;

end;
end.