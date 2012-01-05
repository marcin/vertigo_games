program angleworm;
uses crt,graph,windos,msttp;
type score=record
           sz:longint;
           g1:string[255];
           g2:string[255];
           p1:longint;
           p2:longint;
           su:longint
           end;
var  kod_bl,bx,by,opo,xc,yc,color,sterownik,tryb:integer;
{     a,b:array[0..10000] of L;}
     koniec_gry,koniec,koniec1:boolean;
     kolor3,kom,i,r,r1,r2,x,y,x1,y1,kolor,kolor1,czas,lg,g1,g2,tura,kolor2{,com}:integer;
     z_czy,z1_czy,zzz,z,z1:char;
     czas_txt,g1_txt,g2_txt,tura_txt:string[200];
     p12_txt,p1_txt,p2_txt,gracz1,gracz2:string[9];
     kom_txt,opo_txt1,opo_txt:string[2];
     mst,g12,opo_w,muz,kolll,koll,opoz:integer;
     plik :file of score;
     dane:score;
     size:word;
     p:pointer;


label poczatek,end_gry,poczatek_gry;


procedure tytul;
  var t1:integer;
  label poczatek_tla;
  begin
    poczatek_tla:
    t1:=getmaxx;
    cleardevice;
{    SetFillStyle(,0);}
    SetColor(7);
{    bar(0,0,getmaxx,getmaxy);}
    Rectangle(0,0,getmaxx,getmaxy);
    SettextStyle(11,0,11);
    setcolor(green);
    OutTextXY(100,getmaxy-40,'(C) 9 Maj 1995 by VertigO');
    OutTextXY(100,getmaxy-30,'   Marcin Stefaniak');
    SetColor(brown);
{    OutTextXY(50,getmaxy-10,' Wersja dla Protasa (IaLO 94/95   III LO w Siedlcach)');}

    SetTextJustify(1,2);
    SetColor(lightblue);
    SetTextStyle(5,0,7);
    OutTextXY(GetMaxX div 2,0,'Kreski');
    OutTextXY(GetMaxX div 2+1,0,'Kreski');
    OutTextXY(GetMaxX div 2,1,'Kreski');
    SetTextStyle(4,0,7);
    SetTextStyle(4,0,4);
    SetColor(3);
    OutTextXy(t1 div 2,100,'F1-gracz 1              F2-gracz 2');
    OutTextXy(t1 div 2,200,'F3-szybkosc             F4-komputer');
    OutTextXy(t1 div 2,300,'F5-start          F6-najlepsze wyniki');
    OutTextXy(t1 div 2+9,350,'          F10-wyjscie');
    setColor(red);
    outTextxY(513,140,gracz2);
    outTextxY(104,140,gracz1);
    OutTextXy(129,240,opo_txt);
    OutTextXy(120+400+5,240,kom_txt);


    SettextJustify(0,2);
    SetFillStyle(0,0);
    mst:=random(2)+1;
    if mst=11 then z1:='z';
    if mst=12 then z1:='c';
    if mst=1 then z1:='s';
    if mst=2 then z1:='x';
    x1:=random(600)+20;y1:=random(479)+1;

{x1:=4;y1:=354;
    SetColor(7);
    Rectangle(0,350,getmaxx,435);}
    kolor1:=14;
{    kom:=4;}

    kolll:=random(4)+1;
    mst:=0;
    Repeat

{    if mst=4000 then begin
    SetColor(0);
    SettextStyle(20,0,0);}
{    OutTextXY(100,getmaxy-40,'(C) 9 Maj 1995 by ');
    OutTextXY(100,getmaxy-30,'    Marcin Stefaniak');}
{    setcolor(red);
    end;}
    if mst<5000 then mst:=mst+1;
    if keypressed then z:=readkey;

    if z=#64 then
    begin
                 koniec1:=false;
                 SettextStyle(9,0,1);
                 Assign(plik,'kreski.dat');
                 Reset(plik);
                 Read(plik,dane);
                 if dane.su<>dane.p1+dane.p2 then halt;
                 {if dane.p1+dane.p2<g1+g2 then
                 begin
                   dane.sz:=opo_w;
                   dane.g1:=gracz1;
                   dane.g2:=gracz2;
                   dane.p1:=g1;
                   dane.p2:=g2;
                   Write(plik,dane);
                 end;}
                 SetColor(lightgreen);
                 Close(plik);
                 ClearDevice;
                 OutTextXy(10,10,'Szybkosc');
                 str(dane.sz,opo_txt1);
                 OutTextXy(150,10,opo_txt1);
                 SetTextStyle(5,0,5);
                 SetColor(13);
                 OuttextXY(10,50,dane.g1);
                 Str(dane.p1,p1_txt);
                 OutTextXY(200,50,p1_txt);
                 OutTextXY(10,100,dane.g2);
                 str(dane.p2,p2_txt);
                 OutTextXY(200,100,p2_txt);
                 str((dane.p1+dane.p2),p12_txt);
                 SetColor(3);
                 OutTextXY(200,160,p12_txt);
                 OutTextXy(10,160,'Lacznie');

                 Repeat
                 z:=readkey;
                 until z=' ';
                 goto poczatek_tla;
             

    end;

    if z=#59{F1} then
    begin
      Sound(100);
      delay(100);

      Bar(55,140,60+150,190);
      SettextJustify(0,2);
      nosound;
      gracz1:='';
      For i:=1 to 8 do
      begin
        z:=readkey;
        if z=#13 then begin i:=8;end
        else gracz1:=gracz1+z;

        outTextxY(55,140,gracz1);
      end;
      sound(1000);delay(200);nosound;
    end;

    if z=#60{F2} then
    begin
      lg:=2;
      Sound(100);
      delay(100);
            Bar(450,140,450+150,190);
      SettextJustify(0,2);

      SettextJustify(0,2);
      nosound;
      gracz2:='';
      For i:=1 to 8 do
      begin
      
        z:=readkey;
        if (z=#13) and (i>2) then i:=8
        else gracz2:=gracz2+z;
        if (z=#13) and (i<3) then begin       Bar(450,140,450+150,190);gracz2:='Komputer';lg:=1;i:=8;end;
        outTextxY(450,140,gracz2);
      end;
      sound(1000);delay(200);nosound;
    end;

{    if z=#61 {f3} {then
    begin

      bar(116,240,140,280);
      opo_txt:='';
      z:=readkey;
      opo_txt:=z;
      OutTextXy(120,240,opo_txt);
      z:=readkey;
      val(opo_txt,opo_w,kod_bl);
      opo:=10-(opo_w+4);

    end;
}
    if z=#68 then koniec_gry:=true;
        if z=#61 {f3} then
    begin

      bar(116,240,140,280);
{      opo_txt:='';
      z:=readkey;
      opo_txt:=z;}
      opo_w:=opo_w+1;
      if opo_w>9 then opo_w:=0;
      str(opo_w,opo_txt);
      OutTextXy(120,240,opo_txt);
{      z:=readkey;}
{      val(opo_txt,opo_w,kod_bl);}
      opo:=10-(opo_w+4);
            z:='+';

    end;


    if z=#62 then{f4}
    begin
          bar(116+400-20,240,140+25+400,280);
{      opo_txt:='';
      z:=readkey;
      opo_txt:=z;}
      kom:=kom+1;
      if kom>30 then kom:=0;
      str(kom,kom_txt);
      OutTextXy(120+400,240,kom_txt);
            z:='+';

end;

    if koniec1=false
    then begin
               koll:=koll+1;

               if kolll=1 then begin
               if koll<30 then kolor1:=red;
               if koll>30 then kolor1:=white;
               if koll>60 then koll:=0;
               if kolor1>15 then kolor1:=1;
               end;
               if kolll>1 then begin
               if koll=30 then kolor1:=random(15)+1;
               if koll=60 then kolor1:=random(15)+1;
               if koll>60 then koll:=0;
               end;




                  if z1='s' then if GetPixel(x1,y1-1)<>0 then koniec1:=true;
               if z1='x' then if GetPixel(x1,y1+1)<>0 then koniec1:=true;
               if z1='z' then if GetPixel(x1-1,y1)<>0 then koniec1:=true;
               if z1='c' then if GetPixel(x1+1,y1)<>0 then koniec1:=true;

               if z1='s' then y1:=y1-1;
               if z1='x' then y1:=y1+1;
               if z1='z' then x1:=x1-1;
               if z1='c' then x1:=x1+1;
               if (x1<1) or (x1>GetMaxX-1) or (Y1<1) or (y1>GetMaxY) then koniec1:=true;
               PutPixel(x1,y1,kolor1);




                   {dol}
            if z1='x' then

              if (GetPixel(x1,y1+5)<>0)or(GetPixel(x1,y1+kom)<>0)or(GetPixel(x1,y1+3)<>0)or(GetPixel(x1,y1+4)<>0)then
{              r:=0;
              for i:=1 to kom do
              r:=r+GetPixel(x1,y1+i);
              if r>0 then}
              begin
                r1:=0;r2:=0;
          {      for i:=1 to 30 do
                r1:=r1+GetPixel(x1+i,y1);
                for i:=1 to 30 do
                r2:=r2+GetPixel(x1-30+i,y1);}
                for i:=1 to 30 do
                if GetPixel(x1+i,y1)>0 then r1:=r1+30-i;
                for i:=1 to 30 do
                if GetPixel(x1-31+i,y1)>0 then r2:=r2+i;

                r:=random(2);
                if r1>r2 then r:=1;
                if r2>r1 then r:=0;
                if r=1 then z1:='z';
                if r=0 then z1:='c';
              end;
                    {gora}
            r:=0;
            if z1='s' then
{              for i:=1 to 9 do
              r:=r+GetPixel(x1,y1-10+i);}
              if (GetPixel(x1,y1-5)<>0)or(GetPixel(x1,y1-kom)<>0)or(GetPixel(x1,y1-3)<>0)or(GetPixel(x1,y1-4)<>0)then
{              if r>0 then                }
              begin
                r1:=0;r2:=0;
{                for i:=1 to 30 do
                r1:=r1+GetPixel(x1+i,y1);
                for i:=1 to 30 do
                r2:=r2+GetPixel(x1-30+i,y1);}
                for i:=1 to 30 do
                if GetPixel(x1+i,y1)>0 then r1:=r1+30-i;
                for i:=1 to 30 do
                if GetPixel(x1-31+i,y1)>0 then r2:=r2+i;
                if r1=r2 then r:=random(2);
                if r1>r2 then r:=0;
                if r2>r1 then r:=1;

                if r=0 then z1:='z';
                if r=1 then z1:='c';
              end;
                   {lewo}
            if z1='z' then

              if (GetPixel(x1-5,y1)<>0)or(GetPixel(x1-kom,y1)<>0)or(GetPixel(x1-3,y1)<>0)or(GetPixel(x1-4,y1)<>0)then
{              r:=0;
              for i:=1 to kom do
              r:=r+GetPixel(x1-kom+1+i,y1);
              if r>0 then}
              begin
                r1:=0;r2:=0;
                {for i:=1 to 30 do
                r1:=r1+GetPixel(x1,y1+i);
                for i:=1 to 30 do
                r2:=r2+GetPixel(x1,y1-30+i);}
                for i:=1 to 30 do
                if GetPixel(x1,y1+i)>0 then r1:=r1+30-i;
                for i:=1 to 30 do
                if GetPixel(x1,y1-31+i)>0 then r2:=r2+i;
                if r1=r2 then r:=random(2);
                if r1>r2 then r:=1;
                if r2>r1 then r:=0;
                if r=0 then z1:='x';
                if r=1 then z1:='s';

              end;
                      {prawo}
            if z1='c' then

              if (GetPixel(x1+5,y1)<>0)or(GetPixel(x1+kom,y1)<>0)or(GetPixel(x1+3,y1)<>0)or(GetPixel(x1+4,y1)<>0)then
{              r:=0;
              for i:=1 to kom do
              r:=r+GetPixel(x1+i,y1);
              if r>0 then}
              begin

                r1:=0;r2:=0;
{                for i:=1 to 30 do
                r1:=r1+GetPixel(x1,y1+i);
                for i:=1 to 30 do
                r2:=r2+GetPixel(x1,y1-30+i);}
                for i:=1 to 30 do
                if GetPixel(x1,y1+i)>0 then r1:=r1+30-i;
                for i:=1 to 30 do
                if GetPixel(x1,y1-31+i)>0 then r2:=r2+i;
                r:=random(2);
                if r1>r2 then r:=1;
                if r2>r1 then r:=0;
                if r=0 then z1:='x';
                if r=1 then z1:='s';
              end;
              {randomize;
              r:=random(11112);
              if( r=111) and (z1='c') or (z1='z')then z1:='s';
              if( r=112)and (z1='c') or (z1='z') then z1:='x';
              if (r=113)and (z1='s') or (z1='x') then z1:='z';
              if (r=114)and (z1='s') or (z1='x') then z1:='c';}

   end;


    Until (z=#63)or (z=#68);


  end;

{****************************************************************************}

begin


  bx:=7;
  by:=5;
  color:=1;
  kolor2:=3;
  kolor3:=7;
  randomize;
  kom:=1;


  sterownik:=vga;
  tryb:=vgaHi;
  InitGraph(sterownik,tryb,'c:\tp\bgi');
{  m_load('glowa',200,100);
  SIZE:=IMAGEsize(200,100,200+177,100+209);
  getMem(p,size);
  getimage(200,100,200+177,100+209,p^);}


    lg:=1;
    gracz1:='VertigO';
    gracz2:='Komputer';
    opo:=3;
    opo_w:=3;
    opo_txt:='3';
    kom:=4;
    kom_txt:='4';

  poczatek_gry:
  koniec_gry:=false;

  tytul;
  if koniec_gry=true then goto end_gry;
  setTextStyle(11,0,11);

  g1:=0;g2:=0;
  {sdsdds0;}
  tura:=0;
  poczatek:
  OutTextXY(getmaxx-10,GetMaxY-16,opo_txt);
  if lg=1 then
  begin
  r:=random(4)+1;
  if r=1 then z1:='s';
  if r=2 then z1:='c';
  if r=3 then z1:='z';
  if r=4 then z1:='x';
  end
  else z1:='z';
  ClearDevice;
  SetColor(3);
  OutTextXy(300,200,'Tura:');
  str(tura,tura_txt);
  OutTextXy(340,200,tura_txt);
  delay(1000);
  cleardevice;
{  putimage(random(450)+10,random(100)+100,p^,normalput);}


  czas:=0;
  koniec:=false;
  koniec1:=false;
  x:=100;
  y:=100;
  z:=#77;
{  z1:='x';}
  kolor:=12;
  kolor1:=10;
  x1:=400;
  y1:=100;


  SetColor(7);
  Rectangle(0,0,GetMaxX,GetMaxY-20);
  SetColor(2);
  OutTextXy(0,GetMaxY-15,'Czas:');
  OutTextXy(0+130,GetMaxY-15,'Tura:');
  SetColor(7);
  OutTextXy(0+130+40,GetMaxY-15,tura_txt);
  SetColor(3);
  OuttextXy(250,GetMaxY-15,gracz1);
  OutTextXy(450,getmaxY-15,gracz2);
  Str(g1,g1_txt);
  Str(g2,g2_txt);
  SetColor(7);
  If g1>0 then OutTextXY(350,GetMaxY-15,g1_txt);
  if g2>0 then OutTextXy(550,GetMaxY-15,g2_txt);

  koll:=0;
  Repeat
{    kolor1:=random(2)+3;}
    koll:=koll+1;
    kolll:=kolll+1;
    if koll>30 then kolor:=15;
    if koll<30 then kolor:=red;
    if koll>60 then koll:=0;
    if kolll>10 then kolor1:=lightblue;
    if kolll<10 then kolor1:=lightgreen;
    if kolll>20 then kolll:=0;

    If KeyPressed then
    begin
      zzz:=readkey;
      if zzz='q' then goto poczatek_gry;
{      if zzz=#75 and z}
      if ((zzz<>#72) and (z=#80)) or( (zzz<>#80) and (z=#72)) or((zzz<>#75) and (z=#77)) or((zzz<>#77) and (z=#75)) then
      if (zzz=#72) or (zzz=#80) or (zzz=#75) or (zzz=#77) then z:=zzz;


      if (zzz<>'s') and (z1='x') or (zzz<>'x') and (z1='s') or(zzz<>'z') and (z1='c') or(zzz<>'c') and (z1='z') then
      if (zzz='s') or (zzz='x') or (zzz='z') or (zzz='c') then z1:=zzz;





      {case z of
      #72:gora
      #80:dol
      #75:lewo
      #77:prawo
      }

   end;

     {  if z<>z_czy then
         begin
        z_czy:=z;
        if z=#72 then Sound(523);
        if z=#80 then Sound(1047);
        if z=#75 then Sound(262);
        if z=#77 then Sound(131);

        muz:=30;
        end;
      if z1<>z1_czy then
      begin
        z1_czy:=z1;
        if z1='s' then Sound(1623);
        if z1='z' then Sound(247);
        if z1='x' then Sound(552);
        if z1='c' then Sound(931);
        muz:=30;
      end;

   if muz>0 then muz:=muz-1;
   if muz=1 then NoSound;}

   if z=#72 then if GetPixel(x,y-1)<>0 then koniec:=true;
   if z=#80 then if GetPixel(x,y+1)<>0 then koniec:=true;
   if z=#75 then if GetPixel(x-1,y)<>0 then koniec:=true;
   if z=#77 then if GetPixel(x+1,y)<>0 then koniec:=true;


   putpixel(x,y,kolor);
   if z=#72 then y:=y-1;
   if z=#80 then y:=y+1;
   if z=#75 then x:=x-1;
   if z=#77 then x:=x+1;

   if (x<1) or (x>GetMaxX-1) or (Y<1) or (y>GetMaxY-20) then koniec:=true;

   putpixel(x,y,15);


   if lg=2 then
   begin
      if z1='s' then if GetPixel(x1,y1-1)<>0 then koniec1:=true;
      if z1='x' then if GetPixel(x1,y1+1)<>0 then koniec1:=true;
      if z1='z' then if GetPixel(x1-1,y1)<>0 then koniec1:=true;
      if z1='c' then if GetPixel(x1+1,y1)<>0 then koniec1:=true;

{      PutPixel(x1,y1,15);}
      if z1='s' then y1:=y1-1;
      if z1='x' then y1:=y1+1;
      if z1='z' then x1:=x1-1;
      if z1='c' then x1:=x1+1;
      if (x1<1) or (x1>GetMaxX-1) or (Y1<1) or (y1>GetMaxY-20) then koniec1:=true;
      PutPixel(x1,y1,kolor1);
   end
   else
   begin
                  if z1='s' then if GetPixel(x1,y1-1)<>0 then koniec1:=true;
               if z1='x' then if GetPixel(x1,y1+1)<>0 then koniec1:=true;
               if z1='z' then if GetPixel(x1-1,y1)<>0 then koniec1:=true;
               if z1='c' then if GetPixel(x1+1,y1)<>0 then koniec1:=true;

               if z1='s' then y1:=y1-1;
               if z1='x' then y1:=y1+1;
               if z1='z' then x1:=x1-1;
               if z1='c' then x1:=x1+1;
               if (x1<1) or (x1>GetMaxX-1) or (Y1<1) or (y1>GetMaxY-20) then koniec1:=true;
               PutPixel(x1,y1,kolor1);




                   {dol}
            if z1='x' then

              if (GetPixel(x1,y1+5)<>0)or(GetPixel(x1,y1+kom)<>0)or(GetPixel(x1,y1+3)<>0)or(GetPixel(x1,y1+4)<>0)then
{              r:=0;
              for i:=1 to kom do
              r:=r+GetPixel(x1,y1+i);
              if r>0 then}
              begin
                r1:=0;r2:=0;
          {      for i:=1 to 30 do
                r1:=r1+GetPixel(x1+i,y1);
                for i:=1 to 30 do
                r2:=r2+GetPixel(x1-30+i,y1);}
                for i:=1 to 30 do
                if GetPixel(x1+i,y1)>0 then r1:=r1+30-i;
                for i:=1 to 30 do
                if GetPixel(x1-31+i,y1)>0 then r2:=r2+i;

                r:=random(2);
                if r1>r2 then r:=1;
                if r2>r1 then r:=0;
                if r=1 then z1:='z';
                if r=0 then z1:='c';
              end;
                    {gora}
            r:=0;
            if z1='s' then
{              for i:=1 to 9 do
              r:=r+GetPixel(x1,y1-10+i);}
              if (GetPixel(x1,y1-5)<>0)or(GetPixel(x1,y1-kom)<>0)or(GetPixel(x1,y1-3)<>0)or(GetPixel(x1,y1-4)<>0)then
{              if r>0 then                }
              begin
                r1:=0;r2:=0;
{                for i:=1 to 30 do
                r1:=r1+GetPixel(x1+i,y1);
                for i:=1 to 30 do
                r2:=r2+GetPixel(x1-30+i,y1);}
                for i:=1 to 30 do
                if GetPixel(x1+i,y1)>0 then r1:=r1+30-i;
                for i:=1 to 30 do
                if GetPixel(x1-31+i,y1)>0 then r2:=r2+i;
                if r1=r2 then r:=random(2);
                if r1>r2 then r:=0;
                if r2>r1 then r:=1;

                if r=0 then z1:='z';
                if r=1 then z1:='c';
              end;
                   {lewo}
            if z1='z' then

              if (GetPixel(x1-5,y1)<>0)or(GetPixel(x1-kom,y1)<>0)or(GetPixel(x1-3,y1)<>0)or(GetPixel(x1-4,y1)<>0)then
{              r:=0;
              for i:=1 to kom do
              r:=r+GetPixel(x1-kom+1+i,y1);
              if r>0 then}
              begin
                r1:=0;r2:=0;
                {for i:=1 to 30 do
                r1:=r1+GetPixel(x1,y1+i);
                for i:=1 to 30 do
                r2:=r2+GetPixel(x1,y1-30+i);}
                for i:=1 to 30 do
                if GetPixel(x1,y1+i)>0 then r1:=r1+30-i;
                for i:=1 to 30 do
                if GetPixel(x1,y1-31+i)>0 then r2:=r2+i;
                if r1=r2 then r:=random(2);
                if r1>r2 then r:=1;
                if r2>r1 then r:=0;
                if r=0 then z1:='x';
                if r=1 then z1:='s';

              end;
                      {prawo}
            if z1='c' then

              if (GetPixel(x1+5,y1)<>0)or(GetPixel(x1+kom,y1)<>0)or(GetPixel(x1+3,y1)<>0)or(GetPixel(x1+4,y1)<>0)then
{              r:=0;
              for i:=1 to kom do
              r:=r+GetPixel(x1+i,y1);
              if r>0 then}
              begin

                r1:=0;r2:=0;
{                for i:=1 to 30 do
                r1:=r1+GetPixel(x1,y1+i);
                for i:=1 to 30 do
                r2:=r2+GetPixel(x1,y1-30+i);}
                for i:=1 to 30 do
                if GetPixel(x1,y1+i)>0 then r1:=r1+30-i;
                for i:=1 to 30 do
                if GetPixel(x1,y1-31+i)>0 then r2:=r2+i;
                r:=random(2);
                if r1>r2 then r:=1;
                if r2>r1 then r:=0;
                if r=0 then z1:='x';
                if r=1 then z1:='s';
              end;
              {randomize;
              r:=random(11112);
              if( r=111) and (z1='c') or (z1='z')then z1:='s';
              if( r=112)and (z1='c') or (z1='z') then z1:='x';
              if (r=113)and (z1='s') or (z1='x') then z1:='z';
              if (r=114)and (z1='s') or (z1='x') then z1:='c';}


     end;


   if opo=0 then
   begin
     opoz:=opoz+1;
     if opoz=10 then
     begin
       opoz:=0;
       delay(5);
     end;
   end;
   if opo=-1 then
   begin
     opoz:=opoz+1;
     if opoz=10 then
     begin
       opoz:=0;
       delay(2);
     end;
   end;
   if opo=-2 then
    begin
      opoz:=opoz+1;
      if opoz=10 then
      begin
        opoz:=0;
        delay(1);
      end;
    end;


   if opo>-1 then delay(opo);
   SetColor(0);
   OutTextXy(50,GetMaxY-15,czas_txt);
   Czas:=czas+1;
   Str(czas,czas_txt);
{   SetFillStyle(0,0);
   Bar(50,GetMaxY-15,150,getMaxY);}
   SetColor(7);
   OutTextXy(50,GetMaxY-15,czas_txt);
   OutTextXY(GetMaxX-10,GetMaxY-16,opo_txt);

  Until koniec or koniec1;
  nosound;
  if koniec then g2:=czas+g2;
  if koniec1 then g1:=czas+g1;
  tura:=tura+1;
  repeat
    if keypressed then z:=readkey;
  until not keypressed;
{  repeat}
  z:=readkey;
{  until z=' ';}
  if tura<10 then goto poczatek;
    Assign(plik,'kreski.dat');
  Reset(plik);
  Read(plik,dane);
  if dane.p1+dane.p2<g1+g2 then
  begin
    rewrite(plik);
    dane.sz:=opo_w;
    dane.g1:=gracz1;
    dane.g2:=gracz2;
    dane.p1:=g1;
    dane.p2:=g2;
    dane.su:=g1+g2;
    Write(plik,dane);
  end;
  Close(plik);
  ClearDevice;
  SetTextStyle(7,0,5);
  SetColor(10);
  OutTextXy(10,10,'Szybkosc');
  OutTextXy(150+100,10,opo_txt);
  settextStyle(7,0,7);
  setColor(13);
  OuttextXY(10,50,gracz1);
  Str(g1,p1_txt);
  OutTextXY(200+200,50,p1_txt);
  OutTextXY(10,100,gracz2);
  str(g2,p2_txt);
  OutTextXY(200+200,100,p2_txt);
  g12:=g1+g2;
  str(g12,p12_txt);
  SetColor(3);
  OutTextXY(200+200,160,p12_txt);
  OutTextXy(10,160,'Suma:');
  Repeat
  z:=readkey;
  until z=' ';
  goto poczatek_gry;



  Sound(100);
  delay(100);
  Nosound;
  delay(5000);
  end_gry:
  CloseGraph;

end.
