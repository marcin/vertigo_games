program VertigO;

uses Crt, Dos, Graph, vermodul;
var z_z:char;

{const MouseInt = $33;

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
  b:char;}

Label start,endtur,theend1,definitywnykoniec,gragraczII,gr1aczy;

{*****************************************************************************}
begin
clrscr;
Write('VertigO potrzebuje myszki, czy twoja mysz jest zainstalowana ? (T/N) ');
repeat
z_z:=readkey;
z_z:=UpCase(z_z);
until (z_z='T') or (z_z='N');
if z_z='N' then Halt;
  start:
  h1:=0;h2:=0;h3:=0;h4:=0;h5:=0;h6:=0;h7:=0;h8:=0;h9:=0;h10:=0;h11:=0;h12:=0;
  h13:=0;h21:=0;h22:=0;h23:=0;h24:=0;h25:=0;h26:=0;h27:=0;h28:=0;h29:=0;h30:=0;h31:=0;h32:=0;h33:=0;
  g1:=0;g2:=0;g3:=0;g4:=0;g5:=0;g6:=0;g7:=0;g8:=0;g9:=0;g10:=0;g11:=0;g12:=0;
  g13:=0;g21:=0;g22:=0;g23:=0;g24:=0;g25:=0;g26:=0;g27:=0;g28:=0;g29:=0;g30:=0;g31:=0;g32:=0;g33:=0;
  w:=0;
  dk:=0;
  theend:=0;
  cyfraI1:=100;cyfraI2:=100;cyfraII1:=100;cyfraII2:=100;
  koniec:=0;
  vgainit;
  {czasm1:=0;czasm2:=0;czass1:=0;czass2:=0;tura1:=0;tyra2:=0;}
  tura:=0;
  gg1:=0;gg2:=0;
  st:=0;los_g1:=10;los_g2:=10;
  del:=0;
  graczy:=2;
  randomize;
  poczatek;
  if dk=123 then goto definitywnykoniec;
  v_grI;
  MouseNot;
  if graczy=2 then v_grII;





    SetActivePage(0);
  ClearDevice;
  SetVisualPage(0);
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

  SetViewPort(1,1,310,330,clipoN);
  SetViewPort(0,0,getmaxx,getmaxy,clipon);
  tlo(100+183,308+10,163+193,330+10);
  SetColor(8);
  SetTextStyle(2,0,6);
  OutTextXY(119+183,310+8,'wiem');
  OutTextXY(118+183,310+8,'wiem');


  endtur:

  cyfra1:=10;cyfra2:=10;
  SetTextStyle(2,0,6);
  tura:=tura+1;
  if tura=100 then begin pl:=3;goto theend1; end;
  str(tura,tura1);
  t:=TextWidth(tura1);
  t2:=t div 2;
  tlo(302,53,335,72+2);
  OutTextXY(320-t2,54,tura1);
  OutTextXY(321-t2,54,tura1);

  if (gg1>0) or (graczy=1) then
  begin
    gg1:=gg1-1 ;
    goto gragraczII;
  end;

  SetViewPort(0,0,getMaxX,getMaxY,clipon);
  SetTextStyle(1,0,4);
  t1:=TextWidth(gracz1);
  t:=t1 div 2;
  Tlo1(155-t-20,279,155+t+17,275+40,3,15,8);
  SetColor(1);
  OutTextXY(150-t,277,gracz1);


  SetActivePage(1);
  SetVisualPage(1);


  SetViewPort(1,1,310,330,clipoN);

  koniec:=0;
  repeat
    MouseShow;
    pl:=1;
    if gg1=0 then koniecgry;
    if st=1 then goto start;
    if theend=1 then  goto theend1;
    SetViewPort(1,1,310,330,clipoN);
    w:=0;

    MousePos(x,y,p);
    SetFillStyle(4,13);

    barx:=28;bary:=8;
    if p=1 then
    begin
      MouseNot;
      Repeat;
        MousePos(x,y,p);
      until p=0;
      for i:=1 to 100 do
      begin

        bar1x:=barx+23;bar1y:=bary+23;

        if (x>barx) and (x<bar1x) and (y>bary) and (y<bar1y) then
        begin

          w:=i;
        end;
        if w>0 then
        begin
          if(w=h1)or(w=h2)or(w=h3)or(w=h4)or(w=h5)or(w=h6)or(w=h7)or(w=h8)or(w=h9)or(w=h10)or(w=h11)or(w=h12)or(w=h13)then
          begin
          SetFillStyle(1,red);
          bar(barx,bary,bar1x,bar1y);
          end
          else
          if (w=h21)or(w=h22)or(w=h23)or(w=h24)or(w=h25)or(w=h26)or(w=h27)or(w=h28)or(w=h29)or(w=h30)or(w=h31)then
          begin
          SetFillStyle(1,red);
          bar(barx,bary,bar1x,bar1y);
          end
          else
          if (w=h32)or(w=h33)then
          begin
          SetFillStyle(1,red);
          bar(barx,bary,bar1x,bar1y);
          end
          else
          begin
             SetFillStyle(8,10);
             FloodFill(barx,bary,7);
            {setFillStyle(1,green);
            bar(barx,bary,bar1x,bar1y);}
          end;
          w:=0;
          koniec:=1;
        end;
        barx:=barx+25;
        if barx=278 then
        begin
          barx:=28;
          bary:=bary+25;
        end;
      end;
    end;
  until koniec=1;

  gragraczII:
  {if graczy=1 then goto gr1aczy;}

  if gg2>0 then
  begin
    gg2:=gg2-1;
    goto endtur;
  end;

  koniec:=0;
  cyfra1:=10;cyfra2:=10;
  setViewPort(0,0,getMaxX,getMaxY,clipon);

  SetTextStyle(1,0,4);
  t1:=TextWidth(gracz1);
  t:=t1 div 2;
  Tlo(155-t-20,279,155+t+17,275+40);
  SetColor(1);
  OutTextXY(150-t,277,gracz1);

  t1:=TextWidth(gracz2);
  t:=t1 div 2;
  Tlo1(490-t-20,279,490+t+17,275+40,3,15,8);
  SetColor(1);
  OutTextXY(490-t,277,gracz2);


  SetViewPort(332,1,630,330,clipon);

  repeat
  MouseShow;
  pl:=2;
  if gg2=0 then koniecgry;
  if st=1 then goto start;
  if theend=1 then goto theend1;
  SetViewPort(332,1,630,330,clipon);
    w:=0;

    MousePos(x,y,p);

    SetFillStyle(4,13);

    barx:=28;bary:=8;
    if p=1 then
    begin
      MouseNot;
      Repeat;
        MousePos(x,y,p);
      until p=0;
      x:=x-331;
      for i:=1 to 100 do
      begin
        bar1x:=barx+23;bar1y:=bary+23;

        if (x>barx) and (x<bar1x) and (y>bary) and (y<bar1y) then
        begin

          w:=i;
        end;
        if w>0 then
        begin
          if(w=g1)or(w=g2)or(w=g3)or(w=g4)or(w=g5)or(w=g6)or(w=g7)or(w=g8)or(w=g9)or(w=g10)or(w=g11)or(w=g12)or(w=g13)then
          begin
          SetFillStyle(1,red);
          bar(barx,bary,bar1x,bar1y);
          end
          else
          if (w=g21)or(w=g22)or(w=g23)or(w=g24)or(w=g25)or(w=g26)or(w=g27)or(w=g28)or(w=g29)or(w=g30)or(w=g31)then
          begin
          SetFillStyle(1,red);
          bar(barx,bary,bar1x,bar1y);
          end
          else
          if (w=g32)or(w=g33)then
          begin
          SetFillStyle(1,red);
          bar(barx,bary,bar1x,bar1y);
          end
          else
          begin
             SetFillStyle(8,14);
             FloodFill(barx,bary,7);

          end;
          w:=0;
          koniec:=1;
        end;
        barx:=barx+25;
        if barx=278 then
        begin
          barx:=28;
          bary:=bary+25;
        end;
      end;
    end;
  until koniec=1;

  gr1aczy:
  SetViewPort(0,0,getMaxX,getMaxY,clipon);

  SetTextStyle(1,0,4);
  t1:=TextWidth(gracz2);
  t:=t1 div 2;
  Tlo(490-t-20,279,490+t+17,275+40);
  SetColor(1);
  OutTextXY(490-t,277,gracz2);



  {while keypressed do b:=readkey;
  b:=readkey;}
  if  theend=1 then goto theend1;
  goto endtur;

  theend1:
  SetVisualPage(1);
  Repeat
    MousePos(x,y,p);
  Until p=1;
  Repeat
    MousePos(x,y,p);
  Until p=0;

if p<>1 then  SetViewPort(1,1,310,330,clipoN);
  barx:=28;bary:=8;
  for w:=1 to 100 do
      begin

      bar1x:=barx+23;bar1y:=bary+23;

      if(w=h1)or(w=h2)or(w=h3)or(w=h4)or(w=h5)or(w=h6)or(w=h7)or(w=h8)or(w=h9)or(w=h10)or(w=h11)or(w=h12)or(w=h13)then
      begin
      SetFillStyle(1,red);
      bar(barx,bary,bar1x,bar1y);
      end
      else
      if (w=h21)or(w=h22)or(w=h23)or(w=h24)or(w=h25)or(w=h26)or(w=h27)or(w=h28)or(w=h29)or(w=h30)or(w=h31)then
      begin
      SetFillStyle(1,red);
      bar(barx,bary,bar1x,bar1y);
      end
      else
      if (w=h32)or(w=h33)then
      begin
      SetFillStyle(1,red);
      bar(barx,bary,bar1x,bar1y);
      end
      else
      begin
        SetFillStyle(8,10);
        FloodFill(barx,bary,7);
      end;
      koniec:=koniec+1;
      barx:=barx+25;
      if barx=278 then
      begin
      barx:=28;
      bary:=bary+25;
      end;
      MousePos(x,y,p);
      if p=1 then
      begin
        del:=10;
        repeat
          MousePos(x,y,p)
        until p=0
      end;
      if del>0 then del:=del-1
      else delay(100);
   end;


Repeat
    MousePos(x,y,p);
Until p=1;
Repeat
    MousePos(x,y,p);
  Until p=0;

  SetViewPort(332,1,630,330,clipon);
   barx:=28;bary:=8;
   del:=0;
    for w:=1 to 100 do
      begin

      bar1x:=barx+23;bar1y:=bary+23;

      if(w=g1)or(w=g2)or(w=g3)or(w=g4)or(w=g5)or(w=g6)or(w=g7)or(w=g8)or(w=g9)or(w=g10)or(w=g11)or(w=g12)or(w=g13)then
          begin
          SetFillStyle(1,red);
          bar(barx,bary,bar1x,bar1y);
          end
          else
          if (w=g21)or(w=g22)or(w=g23)or(w=g24)or(w=g25)or(w=g26)or(w=g27)or(w=g28)or(w=g29)or(w=g30)or(w=g31)then
          begin
          SetFillStyle(1,red);
          bar(barx,bary,bar1x,bar1y);
          end
          else
          if (w=g32)or(w=g33)then
          begin
          SetFillStyle(1,red);
          bar(barx,bary,bar1x,bar1y);
          end
          else
          begin
             SetFillStyle(8,14);
            FloodFill(barx,bary,7);
          end;

      koniec:=koniec+1;
    barx:=barx+25;
    if barx=278 then
    begin
    barx:=28;
    bary:=bary+25;
    end;
    MousePos(x,y,p);
    if p=1 then
    begin
     del:=10;
      repeat
        MousePos(x,y,p)
      until p=0
    end;
    if del>0 then del:=del-1
    else delay(100);

   end;


Repeat
    MousePos(x,y,p);
Until p=1;
Repeat
    MousePos(x,y,p);
  Until p=0;

  ClearDevice;
  SetViewPort(0,0,GetMaxx,getMaxy,clipon);
  SetColor(13);
  SetTextStyle(1,0,5);
{if pl<>3 then  OutTextXY(0,0,'Zwyciezca jest :');}
  SetColor(11);
    SetTextStyle(5,0,6);
  cyfraI1:=(cyfraI1*10)+cyfraI2;
  str(cyfraI1,c1txt);
  cyfraII2:=(cyfraII1*10)+cyfraII2;
  str(cyfraII2,c2txt);
  setcolor(13);
  OutTextXY(50,100,'liczba:');OutTextXY(300+70,100,'tur:');
  OutTextXY(51,100,'liczba:');OutTextXY(301+70,100,'tur:');
  setcolor(3);
  if pl=1 then
  begin
    OutTextXY(130,10,gracz1);
    OutTextXY(131,10,gracz1);
    OutTextXY(132,10,gracz1);
    setcolor(14);
    OutTextXY(200,100,c2txt);
    OutTextXY(380+70,100,tura1);
    OutTextXY(201,100,c2txt);
    OutTextXY(381+70,100,tura1);
  end;
  if pl=2 then
     begin
    OutTextXY(130,10,gracz2);
    OutTextXY(131,10,gracz2);
    OutTextXY(132,10,gracz2);
    setcolor(14);
    OutTextXY(200,100,c1txt);
    OutTextXY(380+70,100,tura1);
    OutTextXY(201,100,c1txt);
    OutTextXY(381+70,100,tura1);
  end;
  if pl=3 then OutTextXY(50,100,'Koniec gry');
  Delay(1000);
  repeat
    MousePos(x,y,p);
  until p=1;
  SetActivePage(1);
  ClearDevice;
  SetActivePage(0);
  ClearDevice;
  goto start;
  definitywnykoniec:
  CloseGraph;
  Writeln;
  TextColor(7);
  Write('MSt VertigO');
{  writeln('        ul.Kosciuszki 48');
  writeln('         08-112 Wisniew');}
end.


