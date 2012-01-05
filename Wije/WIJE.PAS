program Wije;
uses crt,windos,dos;
{$M 65521,0,40000}
const
  Segment =$A000;
  MouseInt = $33;
  k8=#72;
  k2=#80;
  k6=#77;
  k4=#75;
  GetMaxX=320;
  GetMaxY=200;
  L=#75;
  P=#77;
  G=#72;
  D=#80;
  dan=64768;

type dane=record
          st,st1:array[0..8]of char;
          komputer,szybkosc,rozciag:integer;
          raz:longint;
          end;
     score=record
             nazwa:array[0..9]of array[0..7]of integer;
             sco:array[0..9] of longint;
            end;
     score1=record
             ole:byte;
             nazwa:array[0..9]of array[0..7]of integer;
             sco:array[0..9] of longint;
           end;
     data=record
          r,d,m:word;
          end;



type
  RGB_Quad = record
               Blue  : byte;
               Green : byte;
               Red   : byte;
             end;
  Scr_RGB = record
              Red   : byte;
              Green : byte;
              Blue  : byte;
            end;

var


pt:text;
raz,rz:longint;
spr:text;
z11:char;
     wi,wii:word;
naz,naz2:array[0..9]of array[0..7] of char;
emse:array[0..35]of char;
    pun,pun2:array[0..9]of longint;
  ttx:string[5];
  Fdata:file of data;
  dat:data;
  d_r,d_m,d_d,d_dd:word;
  szyfr:byte;
  plik:file of dane;
  dP:dane;
  ff:file of score;
  ff1:file of score1;
  df1:score1;
  df:score;
  st,st1:array[0..8]of char;
  komputer,szybkosc,rozciag:integer;
  z,z1,zzz,zk,zO,z1O: CHAR;
  lg,r1,r2,r,bom,a,b,pkt,wybor,zycia,xxx,cz: BYTE;
  memory:^BYTE;
  punkty,punkty1,wynik,os,licz,ddd,ddd1,wydluzenie,PGracz1,Pgracz2,licz_ :WORD;
  xx,x,y,x1,y1:INTEGER;
  i,ii,i_,ii_,i__:LONGINT;
  Gracz1,Gracz2,txt:String[10];
  start,koniec,od_pocz:boolean;


  tlo_f: ARRAY [1..10] OF STRING;
  BMPPalette : array [0..255] of RGB_Quad;
  ScrPalette : array [0..255] of Scr_RGB;
  tablica:array[0..30000]of byte;
  oss,oss2,ostx,osty,ostx2,osty2:array[0..2000]of byte;
{  zOst,z1Ost:array[0..2000]of char;}


  f:file;
  regs : registers;



label end_gry,poczatek_gry;




function getpixel(gx,gy:word):word;
begin
     Memory := Ptr(Segment,320*gy+gx);
     Move (Memory^,bom,1);
     GetPixel:=bom;


end;

{procedure dz;
begin
  sound(100);
  delay(100);
  nosound;

end;}

{Procedure SetPalette;
begin
  for xx := 0 to 256-1 do
    begin
      ScrPalette[xx].Red := BMPPalette[xx].Red shr 2;
      ScrPalette[xx].Green := BMPpalette[xx].Green shr 2;
      ScrPalette[xx].Blue := BMPpalette[xx].Blue shr 2;
    end;
  regs.ah := $10;
  regs.al := $12;
  regs.bx := 0;
  regs.cx := 256;
  regs.es := Seg (ScrPalette);
  regs.dx := Ofs (ScrPalette);
  intr ($10,regs);
end;}

Procedure sciemnij(sx:byte);
var sxx:byte;
begin


for sxx:=0 to 65 div sx do
begin
        for xx := 0 to 256-1 do
          begin
            if ScrPalette[xx].Red>sx then ScrPalette[xx].Red := ScrPalette[xx].red-sx;
            if ScrPalette[xx].Green>sx then ScrPalette[xx].Green :=ScrPalette[xx].green-sx;
            if ScrPalette[xx].Blue>sx then ScrPalette[xx].Blue :=ScrPalette[xx].blue-sx;

            if ScrPalette[xx].Red<=sx then ScrPalette[xx].red:=0;
            if ScrPalette[xx].green<=sx then ScrPalette[xx].green:=0;
            if ScrPalette[xx].blue<=sx then ScrPalette[xx].blue:=0;
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

Procedure SetPalette;
var sxx,sx:byte;
begin

  sx:=7;

  for sxx:=0 to 65 div sx do
  begin
      for xx := 0 to 256-1 do
        begin
          if ScrPalette[xx].Red<BMPPalette[xx].Red shr 2 then ScrPalette[xx].Red:=ScrPalette[xx].Red+sx;
          if ScrPalette[xx].green<BMPPalette[xx].green shr 2 then ScrPalette[xx].green:=ScrPalette[xx].green+sx;
          if ScrPalette[xx].blue<BMPPalette[xx].blue shr 2 then ScrPalette[xx].blue:=ScrPalette[xx].blue+sx;

          if ScrPalette[xx].Red>BMPPalette[xx].Red shr 2 then ScrPalette[xx].Red:=BMPPalette[xx].Red shr 2;
          if ScrPalette[xx].blue>BMPPalette[xx].blue shr 2 then ScrPalette[xx].blue:=BMPPalette[xx].blue shr 2;
          if ScrPalette[xx].green>BMPPalette[xx].green shr 2 then ScrPalette[xx].green:=BMPPalette[xx].green shr 2;

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

procedure czarno;
begin
  For i_:=0 to 255 do
    Begin
      BMPPalette[i_].green:=0;
      BMPPalette[i_].blue:=0;
      BMPPalette[i_].red:=0;
    End;
  SetPalette;
end;

{Procedure naEkran(txtE:string);
begin
  czarno;
  txtE:=txte+'.tga';
  Assign(f,txtE);
  Reset(f,1);
  Seek (f,18);
  BlockRead(f,BMPPalette,256*3,wynik);
  Seek(f,786);
  Memory := Ptr(Segment,0);
  BlockRead(f,Memory^,320*200,wynik);
  Close(f);

end;}
Procedure naEkranD(ll:longint);
begin
  czarno;
{  txtE:=txte+'.tga';}
  Assign(f,'Dane.dat');
  Reset(f,1);
  Seek (f,ll);
  BlockRead(f,BMPPalette,256*3,wynik);
{  Seek(f,786);}
  Memory := Ptr(Segment,0);
  BlockRead(f,Memory^,320*200,wynik);
  Close(f);
{  SetPalette;}
end;

Procedure doTablicyD(ll:longint);
begin
  Assign(f,'Dane.dat');
  Reset(f,1);
  Seek (f,ll);
  BlockRead(f,BMPPalette,256*3,wynik);
{  SetPalette;}
  BlockRead(f,tablicA,320*90,wynik);
  Close(f);
end;

procedure InitMode (mode : byte);
begin
  regs.ah := 0;
  regs.al := mode;
  intr ($10,regs);
end;

procedure InitVesaMode (mode : word);
begin
  regs.ax := $4f02;
  regs.bx := mode;
  intr ($10,regs);
end;




Procedure Rys(x1,y1,x2,y2,x,y:word);
Begin

  For i_:=0 to y2-y1-1 do
    Begin
      Memory := Ptr(Segment,(y+i_)*320+x);
      Move (Tablica[320*(y1+i_)+x1],Memory^,x2-x1);
    End;

end;

Procedure RysCz(x1,y1,x2,y2,x,y,xyz:word);  {bez koloru 0}
Begin
  For i_:=0 to y2-y1-1 do
    Begin
      For ii_:=0 to x2-x1-1 do
        begin
          Move (Tablica[320*(y1+i_)+x1+ii_],bom,1);
          if bom<>xyz then
            begin
              Memory := Ptr(Segment,320*(y+i_)+x+ii_);
              Move(bom,memory^,1);
            end;
        end;
    End;
end;

Procedure kwadrat(kx1,ky1,kx2,ky2,kol:word);
Begin
bom:=kol;

For i_:=0 to kx2-kx1-1 do
begin
  Memory := Ptr(Segment,320*(ky1)+i_+kx1);
  Move(bom,memory^,1);
{  readln;}
end;
For i_:=0 to kx2-kx1-1 do
begin
  Memory := Ptr(Segment,320*(ky2)+i_+kx1);
  Move(bom,memory^,1);
end;
For i_:=0 to ky2-ky1-1 do
begin
  Memory := Ptr(Segment,320*(ky1+i_)+kx1);
  Move(bom,memory^,1);
end;
For i_:=0 to ky2-ky1 do
begin
  Memory := Ptr(Segment,320*(ky1+i_)+kx2);
  Move(bom,memory^,1);
end;


{      Move (Tablica[320*(y1+i_)+x1+ii_],bom,1);
          if bom<>xyz then
            begin
              Memory := Ptr(Segment,320*(y+i_)+x+ii_);
              Move(bom,memory^,1);
            end;}




End;

Procedure WstawL(licz,lx,ly,ll:word);
begin
    if (ll=2)and(licz<10) then
      RysCz(0,37,7,47,lx-8,ly,6);
    if ll=3 then
    begin
      if licz<10 then RysCz(0,37,7,47,lx-8,ly,6);
      if licz<100 then RysCz(0,37,7,47,lx-8*2,ly,6);
    end;


         if licz>999 then
         Begin
           pkt:=licz mod 10;
           RysCz(pkt*8,37,pkt*8+7,47,lx,ly,6);
           licz_:=licz div 10;
           pkt:=licz_ mod 10;
           RysCz(pkt*8,37,pkt*8+7,47,lx-8,ly,6);
           pkt:=(licz_ div 10) mod 10;
           RysCz(pkt*8,37,pkt*8+7,47,lx-8*2,ly,6);
           pkt:=(licz_ div 10) div 10;
           RysCz(pkt*8,37,pkt*8+7,47,lx-8*3,ly,6);
         End
      else
      if licz>99 then
        Begin
          pkt:=licz mod 10;
          RysCz(pkt*8,37,pkt*8+7,47,lx,ly,6);
          pkt:=(licz div 10) mod 10;
          RysCz(pkt*8,37,pkt*8+7,47,lx-8,ly,6);
          pkt:=(licz div 10) div 10;
          RysCz(pkt*8,37,pkt*8+7,47,lx-16,ly,6);
        End
      else
      if licz>9 then
        begin
          pkt:=licz mod 10;
          RysCz(pkt*8,37,pkt*8+7,47,lx,ly,6);
          pkt:=licz div 10;
          RysCz(pkt*8,37,pkt*8+7,47,lx-8,ly,6);
        end
      else
        begin
          pkt:=licz;
          RysCz(pkt*8,37,pkt*8+7,47,lx,ly,6);
        end;



{  RysCz(8*licz,37,8*licz+7,47,lx-8,ly,6);}


end;

Procedure WstawT(zt:array of char;
                 tx,ty:word);
begin


  For i__:=0 to 7 do
    Begin

        xx:=Ord(zt[i__])-65;
        if xx>=0 then
        RysCz(xx*10,47,xx*10+8,57,tx+10*i__,ty,6);
        if zt[i__]='.' then
        begin
          RysCz(26*10,47,26*10+8,57,tx+10*i__,ty,6)
        end


{      RysCz(10*xx,47,10*xx+8,57,tx+10*xx,ty,6);
      readln;                                   }
    End;

end;

Procedure Czysc(c:byte);
var k:array[0..319] of byte;
Begin

c:=random(5)+1;
while cz=c do
  begin
    c:=random(5)+1;
  end;
cz:=c;
for i_:=0 to 319 do k[i_]:=0;


xx:=4;


if c=1 then
  for ii_:=0 to 160 do
  for i_:=0 to 200 do
    begin
      Memory := Ptr(Segment,i_*320+ii_);
      Move (k,Memory^,1);
      Memory := Ptr(Segment,i_*320+(320-ii_));
      Move (k,Memory^,1);
    end;
if c=2 then
  for i:=0 to 100 do
    begin
      Memory := Ptr(Segment,i*320);
      Move (k,Memory^,320);
      Memory := Ptr(Segment,320*200-i*320);
      Move (k,Memory^,320);
      delay(xx);
    end;
if c=3 then
  for i:=0 to 100 do
    begin
      Memory := Ptr(Segment,320*100-i*320);
      Move (k,Memory^,320);
      Memory := Ptr(Segment,320*100+i*320);
      Move (k,Memory^,320);
      delay(xx);
    end;
if c=4 then
  for ii:=0 to 160 do
  for i:=0 to 200 do
    begin
      Memory := Ptr(Segment,i*320+160+ii);
      Move (k,Memory^,1);
      Memory := Ptr(Segment,i*320+160-ii);
      Move (k,Memory^,1);
    end;



if c=5 then
  for i:=0 to 200 do
    begin
      i:=i+1;
      Memory := Ptr(Segment,i*320);
      Move (k,Memory^,320);
      Memory := Ptr(Segment,320*200-(i+1)*320);
      Move (k,Memory^,320);
      delay(xx);
      if i>200 then i:=200;
    end;



End;

procedure wyniki(pk:word;sstt:array of char);

begin
   Assign(ff,'wije.eme');
   Reset(ff);
   Read(ff,df);
   close(ff);


if pk>df.sco[9] then
begin
  for i:=9 downto 0 do
  begin
    if pk>df.sco[i] then
    begin
      if i<9 then df.sco[i+1]:=df.sco[i];
      if i<9 then for ii:=0 to 7 do df.nazwa[i+1][ii]:=df.nazwa[i][ii];
      if i=0 then
      begin
       df.sco[i]:=pk;
       for ii:=0 to 7 do
       df.nazwa[i][ii]:=Ord(sstt[ii])-szyfr;
      end;
    end
    else
    begin

      df.sco[i+1]:=pk;
      for ii:=0 to 7 do
      df.nazwa[i+1][ii]:=Ord(sstt[ii])-szyfr;
      i:=0;
    end;
  end;

{zerowanie for i:=0 to 9 do
df.sco[i]:=0;}
   Rewrite(ff);
   write(ff,df);
   close(ff);
end;

          Assign(ff1,'wyniki.eme');
          Reset(ff1);
          Read(ff1,df1);
          close(ff1);


       if pk>df1.sco[9] then
       begin
         for i:=9 downto 0 do
         begin
           if pk>df1.sco[i] then
           begin
             if i<9 then df1.sco[i+1]:=df1.sco[i];
             if i<9 then for ii:=0 to 7 do df1.nazwa[i+1][ii]:=df1.nazwa[i][ii];
             if i=0 then
             begin
              df1.sco[i]:=pk;
              for ii:=0 to 7 do
              df1.nazwa[i][ii]:=Ord(sstt[ii])-szyfr;
             end;
           end
           else
           begin

             df1.sco[i+1]:=pk;
             for ii:=0 to 7 do
             df1.nazwa[i+1][ii]:=Ord(sstt[ii])-szyfr;
             i:=0;
           end;
         end;

{       for i:=0 to 9 do
       df.sco[i]:=0;}
          Rewrite(ff1);
          write(ff1,df1);
          close(ff1);
       end;


end;

procedure z_pliku_w;
begin
  Assign(ff,'wije.eme');
  Reset(ff);
  read(ff,df);
  for wii:=0 to 9 do
  begin
  pun[wii]:=df.sco[wii];
    for wi:=0 to 7 do naz[wii][wi]:=chr(df.nazwa[wii][wi]+szyfr);
  end;
  close(ff);


  for i:=0 to 9 do
  begin
    WstawT(naz[i],21,19+16*i);
  end;
  for i:=0 to 9 do
  begin
    WstawL(pun[i],132,19+16*i,0);
  end;


      Assign(ff1,'wyniki.eme');
      Reset(ff1);
      read(ff1,df1);
      for wii:=0 to 9 do
      begin
      pun2[wii]:=df1.sco[wii];
        for wi:=0 to 7 do naz2[wii][wi]:=chr(df1.nazwa[wii][wi]+szyfr);
      end;
      close(ff1);

  {    czarno;
      NaEkran('wynem');}
      for i:=0 to 9 do
      begin
        WstawT(naz[i],21,19+16*i);
      end;
      for i:=0 to 9 do
      begin
        if pun[i]>0 then WstawL(pun[i],136-4,19+16*i,0);
      end;
          for i:=0 to 9 do
      begin
        WstawT(naz2[i],182,19+16*i);
      end;
      for i:=0 to 9 do
      begin
        if pun2[i]>0 then WstawL(pun2[i],297-4,19+16*i,0);
      end;


end;


Procedure pokazwyniki;

begin

  czarno;
  NaEkranD(dan*13);

z_pliku_w;






      WstawT(st,21,187);
      WstawL(PGracz1,136-4,187,0);


      if (lg=1)and(komputer>0) then WstawT('KOMPUTER ',182,187);
      if lg=2 then WstawT(st1,182,187);
      if (lg=2)or((lg=1)and(komputer>0)) then WstawL(PGracz2,297-4,187,0);




setpalette;
{rozjasnij;}

if keypressed then
repeat

z:=readkey;
until not keypressed;

z:=readkey;
z:='0';



end;








procedure go;
var
  tab:array[0..57600]of byte;
{  ttx:string[1];}
  os_los,los:longint;
label
  konP1,konP2,goo,ooo;
begin

PGracz1:=0;
PGracz2:=0;

{
Rys(zycia*13,5,zycia*13+14,22,155-5+1,100-5-5-1);}
DoTablicyD(dan*12);
los:=0;
goo:





zycia:=zycia-1;

czysc(cz);
{RysCz(zycia*8,37,zycia*8+6,47,155,90,6);}






Rys(zycia*13,5,zycia*13+14,22,1,1);
los:=Random(9)+1;
if los>3 then los:=los+2;
{Str(los,ttx);}
if los=os_los then
repeat
  los:=Random(9)+1;
  if los>3 then los:=los+2;
until los<>os_los;

os_los:=los;
{ttx:='9';}
{los:=los+1;}

z:=readkey;
NaEkranD(dan*los);
{if los=1 then NaEkranD(dan*los);
if los=1 then NaEkranD(dan*los);}

if los=6 then  z_pliku_w;



SetPalette;

for i:=0 to 1500 do
begin
  oss[i]:=0;
  oss2[i]:=0;
  ostx[i]:=0;
  osty[i]:=0;
  ostx2[i]:=0;
  osty2[i]:=0;
end;
x:=160;
y:=90;
x1:=160;
y1:=90;
z1:='C';
xxx:=0;

licz:=0;
punkty:=0;
os:=0;

Memory := Ptr(Segment,0);
Move (Memory^,tab,320*180);

{NaEkran('tlo');}

Rys(0,5,14,22,176,181);
Rys(0,5,14,22,176-15,181);
Rys(0,5,14,22,176-2*15,181);
Rys(0,5,14,22,176-3*15,181);

{Tekst(184,6,'MARCIN');}
WstawT(st,6,184);
if lg=2 then WstawT(st1,207-6,184)
        else  if komputer>0 then WstawT('KOMPUTER',207-6,184);

WstawL(PGracz1,6+102+6,184,0);
if (lg=2)or(komputer>0) then WstawL(PGracz2,GetMaxX-11,184,0);

{RysCz(0,47,0+8,47+10,6,184,6);}
{readln;}

if keypressed then
repeat
  z:=readkey;
until not keypressed;

Z:=READKEY;
if z=#27 then goto ooo;
z:=l;
{Assign(spr,'txt.ttt');
Rewrite(spr);}

Repeat
{  WstawL(punkty,6+102,184);
  WstawL(punkty,GetMaxX-11,184);}

  if szybkosc<300 then
  delay(300-szybkosc);

  If KeyPressed then
    begin
      zzz:=readkey;
      zzz:=UpCase(zzz);
      if zzz=#0 then zzz:=readkey;
      if keypressed then
        repeat
          zk:=readkey;
        until not keypressed;
      if zzz=#27 then goto ooo;
      if ((zzz<>#72)and(z=#80)) or ((zzz<>#80)and(z=#72)) or((zzz<>#75)and(z=#77))or((zzz<>#77)and(z=#75)) then
      if (zzz=#72)or(zzz=#80) or (zzz=#75)or(zzz=#77) then z:=zzz;


      if lg=2 then
      if (zzz<>'S') and (z1='X') or (zzz<>'X') and (z1='S') or(zzz<>'Z') and (z1='C') or(zzz<>'C') and (z1='Z') then
      if (zzz='S') or (zzz='X') or (zzz='Z') or (zzz='C') then z1:=zzz;

    end;


{ }

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
                    if z1='S' then Sound(1623);
                    if z1='Z' then Sound(247);
                    if z1='X' then Sound(552);
                    if z1='C' then Sound(931);
                    muz:=30;
                  end;

               if muz>0 then muz:=muz-1;
               if muz=1 then NoSound;}



  licz:=licz+1;

  if licz>=(99-rozciag) then
    begin
      licz:=0;
      os:=os+1;
      punkty:=punkty+1;
      if punkty>999 then
         Begin
           pkt:=punkty mod 10;
           Rys(pkt*13,5,pkt*13+14,22,176,181);
           punkty1:=punkty div 10;
           pkt:=punkty1 mod 10;
           Rys(pkt*13,5,pkt*13+14,22,176-15,181);
           pkt:=(punkty1 div 10) mod 10;
           Rys(pkt*13,5,pkt*13+14,22,176-30,181);
           pkt:=(punkty1 div 10) div 10;
           Rys(pkt*13,5,pkt*13+14,22,176-45,181);
         End
      else
      if punkty>99 then
        Begin
          pkt:=punkty mod 10;
          Rys(pkt*13,5,pkt*13+14,22,176,181);
          pkt:=(punkty div 10) mod 10;
          Rys(pkt*13,5,pkt*13+14,22,176-15,181);
          pkt:=(punkty div 10) div 10;
          Rys(pkt*13,5,pkt*13+14,22,176-30,181);
        End
      else
      if punkty>9 then
        begin
          pkt:=punkty mod 10;
          Rys(pkt*13,5,pkt*13+14,22,176,181);
          pkt:=punkty div 10;
          Rys(pkt*13,5,pkt*13+14,22,176-15,181);
        end
      else
        begin
          pkt:=punkty;
          Rys(pkt*13,5,pkt*13+14,22,176,181);
        end;

    end;

  ostx[os]:=x;
  osty[os]:=y;
  if x>255 then oss[os]:=x-255;
  {zost[os]:=zO;}


    if ((z=p)and(zO=g))or((z=d)and(zO=l)) then a:=16;
    if ((z=l)and(zO=g))or((z=d)and(zO=p)) then a:=17;
    if ((z=l)and(zO=d))or((z=g)and(zO=p)) then a:=18;
    if ((z=p)and(zO=d))or((z=g)and(zO=l)) then a:=19;

    if ((z=G)or(z=D))and((zO=G)or(zO=D)) then a:=0+b;
    if ((z=L)or(z=P))and((zO=L)or(zO=P)) then a:=4+b;

    {zamazac - usunac}
    {For i:=0 to 4 do
      Begin
        Memory := Ptr(Segment,(y+i-2)*320+x-2);
        Move (Tab[(y+i-2)*320+x-2],Memory^,5);
      End;}

    RysCz(a*5,0,a*5+5,5,x-2,y-2,15);



    if z=#72 then y:=y-5;
    if z=#80 then y:=y+5;
    if z=#75 then x:=x-5;
    if z=#77 then x:=x+5;

    {sprawdzenie czy BOOM}
    Memory := Ptr(Segment,320*y+x);
    Move (Memory^,bom,1);
    if (x<2)or(x>318)or(y<2)or(y>180-5)or(bom<15) then
      Begin
            if x<8 then x:=8;
            if y<6 then y:=6;
            if x>311 then x:=311;
        for xx:=0 to 4 do
          begin

            RysCz(xx*19+1,23,xx*19+18,23+13,x-8,y-6,15);
            delay(100);
          end;
{      for i:=20 downto 1 do
        begin
          sound(i*100);
          delay(i*10 div 10);
          nosound;
        end;}
      z:=readkey;
{      for i:=0 to bom do dz;}
      goto konP1;
    End;

{writeln('os',os);
for i:=0 to os do
Writeln(osty[i],' ',ostx[i],' ',oss[i]);
z1:=readkey;}

if rozciag<99 then {bez wydl);}
begin




{    if ostx[2]>0 then
    begin}
{      ddd1:=ostx[1];
      if oss[2]>0 then ddd1:=255+oss[2];}
{    end;}
      ddd:=ostx[0];
    if oss[0]>0 then ddd:=255+oss[0];

    {zamazanie konca glizdy}
{if osty[0]=0 then dz;}
    if osty[0]<>0 then
    For i:=0 to 4 do
      Begin
        Memory := Ptr(Segment,(osty[0]+i-2)*320+ddd-2);
        Move (Tab[(osty[0]-2+i)*320+ddd-2],Memory^,5);
      End;






{    ddd:=ostx[1];
    if oss[1]>0 then ddd:=255+oss[1];
    if osty[1]<>0 then
    begin
      For i:=0 to 4 do
      Begin
        Memory := Ptr(Segment,(osty[1]+i-2)*320+ddd-2);
        Move (Tab[(osty[1]-2+i)*320+ddd-2],Memory^,5);
      End;
      RysCz(8*5,0,8*5+5,5,ddd-2,osty[1]-2,15);}
      {if osty[1]>osty[2] then RysCz(9*5,0,9*5+5,5,ddd-2,osty[1]-2,15);}
{      if GetPixel(ddd,osty[1]-5)<16 then RysCz(9*5,0,9*5+5,5,ddd-2,osty[1]-2,15)else
      if GetPixel(ddd+5,osty[1])<16 then RysCz(10*5,0,10*5+5,5,ddd-2,osty[1]-2,15)else
      if GetPixel(ddd-5,osty[1])<16 then RysCz(11*5,0,11*5+5,5,ddd-2,osty[1]-2,15);}
{    end;}
{    For i:=0 to 4 do
      Begin
        Memory := Ptr(Segment,(osty[0]+i-2)*320+ddd-2);
        Move (Tab[(osty[0]-2+i)*320+ddd-2],Memory^,5);
      End;}







end;



   for i:=0 to os do
      begin
        {if ostx[i+1]>0 then} ostx[i]:=ostx[i+1];
{        if osty[i+1]>0 then} osty[i]:=osty[i+1];
 {       if oss[i+1]>0 then} oss[i]:=oss[i+1];
        {zOst[i]:=zOst[i+1];}
      end;

    b:=b+1;
    if b>3 then b:=0;


    if (z=G) then a:=12;
    if (z=D) then a:=13;
    if (z=L) then a:=14;
    if (z=P) then a:=15;

    RysCz(a*5,0,a*5+5,5,x-2,y-2,15);

{    RysCz(a*5,0,a*5+5,5,x-2+10,y-2-10,15);}

    zO:=z;



{222222222222222222222222222222222222222222222222222222222}

if (lg=2)or(komputer>0) then
BEGIN
    ostx2[os]:=x1;
    osty2[os]:=y1;
    if x1>255 then oss2[os]:=x1-255;

    if ((z1='C')and(z1O='S'))or((z1='X')and(z1O='Z')) then a:=16;
    if ((z1='Z')and(z1O='S'))or((z1='X')and(z1O='C')) then a:=17;
    if ((z1='Z')and(z1O='X'))or((z1='S')and(z1O='C')) then a:=18;
    if ((z1='C')and(z1O='X'))or((z1='S')and(z1O='Z')) then a:=19;


    if ((z1='S')or(z1='X'))and((z1O='S')or(z1O='X')) then a:=0+b;
    if ((z1='Z')or(z1='C'))and((z1O='Z')or(z1O='C')) then a:=4+b;

    For i:=0 to 4 do {zamazac - usunac}
      Begin
        Memory := Ptr(Segment,(y1+i-2)*320+x1-2);
        Move (Tab[(y1+i-2)*320+x1-2],Memory^,5);
      End;

    RysCz(a*5+160,0,a*5+5+160,5,x1-2,y1-2,15);



        if z1='S' then y1:=y1-5;
        if z1='X' then y1:=y1+5;
        if z1='Z' then x1:=x1-5;
        if z1='C' then x1:=x1+5;

            {sprawdzenie czy BOOM}
      Memory := Ptr(Segment,320*y1+x1);
      Move (Memory^,bom,1);

    if (x1<2)or(x1>318)or(y1<2)or(y1>180-5)or(bom<16) then
    Begin
      if x1<8 then x1:=8;
      if y1<6 then y1:=6;
      if x1>311 then x1:=311;
      for xx:=0 to 4 do
          begin
            RysCz(xx*19+1,23,xx*19+18,23+13,x1-8,y1-6,15);
            delay(100);
          end;

{      for i:=20 downto 1 do
        begin
          sound(i*50);
          delay(i*10 div 10);
          nosound;
        end;}
      z:=readkey;
      goto konP2;
    End;


if rozciag<99 then {bez wydl);}
begin


      {zamazanie konca glizdy}


    ddd:=ostx2[0];
    if oss2[0]>0 then ddd:=255+oss2[0];
    if osty2[0]>0 then
    For i:=0 to 4 do
    Begin
      Memory := Ptr(Segment,(osty2[0]+i-2)*320+ddd-2);
      Move (Tab[(osty2[0]-2+i)*320+ddd-2],Memory^,5);
    End;
end;


 for i:=0 to os do
  begin
    ostx2[i]:=ostx2[i+1];
    osty2[i]:=osty2[i+1];
    oss2[i]:=oss2[i+1]
  end;


z1O:=z1;

    if lg=1 then
      begin


      if komputer=-100 then
      begin

                  {dol}
        if (z1='X')and(
          (GetPixel(x1,y1+5)<16)or(GetPixel(x1,y1+10)<16)or(GetPixel(x1,y1+15)<16)
          or(y1+5>175)or(y1+10>175)or(y1+15>175))then
          begin
            r1:=0;r2:=0;
            for i:=1 to 5 do if GetPixel(x1+i*5,y1)<=16 then r1:=r1+150-i*i*i;

            for i:=1 to 5 do if GetPixel(x1-i*5,y1)<=16 then r2:=r2+150-i*i*i;

            r:=random(2);
            if r1>r2 then r:=1;
            if r2>r1 then r:=0;
            if r=1 then z1:='Z';
            if r=0 then z1:='C';
            if x1-5<2 then z1:='C';
            if x1+5>318 then z1:='Z';
          end

                   {gora}
          else
        if (z1='S')and(
        (GetPixel(x1,y1-5)<16)or(GetPixel(x1,y1-10)<16)or(GetPixel(x1,y1-15)<16)
        or(y1-5<2)or(y1-10<2)or(y1-15<2))then
          begin
            r1:=0;r2:=0;
            for i:=1 to 5 do if GetPixel(x1+i*5,y1)<=16 then r1:=r1+150-i*i*i;
            for i:=1 to 5 do if GetPixel(x1-i*5,y1)<=16 then r2:=r2+150-i*i*i;
            if r1=r2 then r:=random(2);
            if r1>r2 then r:=0;
            if r2>r1 then r:=1;
            if r=0 then z1:='Z';
            if r=1 then z1:='C';
            if x1-5<2 then z1:='C';
            if x1+5>318 then z1:='Z';
          end
          else

                  {lewo}
        if (z1='Z')and(
        (GetPixel(x1-5,y1)<16)or(GetPixel(x1-10,y1)<16)or(GetPixel(x1-15,y1)<16)
        or(x1-5<2)or(x1-10<2)or(x1-15<2))then

          begin

            r1:=0;r2:=0;
            for i:=1 to 5 do if GetPixel(x1,y1+i*5)>0 then r1:=r1+150-i*i*i;
            for i:=1 to 5 do if GetPixel(x1,y1-i*5)>0 then r2:=r2+150-i*i*i;
            if r1=r2 then r:=random(2);
            if r1>r2 then r:=1;
            if r2>r1 then r:=0;
            if r=0 then z1:='X';
            if r=1 then z1:='S';
            if y1-5<2 then z1:='X';
            if y1+5>175 then z1:='S';

          end
          else
                     {prawo}
        if (z1='C')and(
           (GetPixel(x1+5,y1)<16)or(GetPixel(x1+10,y1)<16)or(GetPixel(x1+15,y1)<16)or
           (x1+5>GetMaxX-2)or(x1+10>GetMaxX-2)or(x1+15>GetMaxX-2))then
          begin
            r1:=0;r2:=0;
            for i:=1 to 5 do if GetPixel(x1,y1+i*5)>0 then r1:=r1+150-I*i*i;
            for i:=1 to 5 do if GetPixel(x1,y1-i*5)>0 then r2:=r2+150-i*i*i;
            r:=random(2);
            if r1>r2 then r:=1;
            if r2>r1 then r:=0;
            if r=0 then z1:='X';
            if r=1 then z1:='S';
            if y1-5<2 then z1:='X';
            if y1+5>175 then z1:='S';
          end;
        end

        else
        begin


                        {dol}
              z11:=z1;
              if (z1='X')and((GetPixel(x1,y1+5)<16)or(y1+5>175)) then
              Begin
                  if (GetPixel(x1+5,y1)<16)or(x1+5>318) then z1:='Z';
                  if (GetPixel(x1-5,y1)<16)or(x1-5<2) then z1:='C';
                  if z11=z1 then
                  begin
                    if random(2)=0 then z1:='Z' else z1:='C';
                  end;


              End
              else

                         {gora}

              if (z1='S')and((GetPixel(x1,y1-5)<16)or(y1-5<2)) then
              Begin
                  if (GetPixel(x1+5,y1)<16)or(x1+5>318) then z1:='Z';
                  if (GetPixel(x1-5,y1)<16)or(x1-5<2) then z1:='C';
                  if z11=z1 then
                  begin
                    if random(2)=0 then z1:='Z' else z1:='C';
                  end;
              End
              else




                        {lewo}
              if (z1='Z')and((GetPixel(x1-5,y1)<16)or(x1-5<2)) then
              Begin
                  if (GetPixel(x1,y1+5)<16)or(y1+5>175) then z1:='S';
                  if (GetPixel(x1,y1-5)<16)or(y1-5<2) then z1:='X';
                  if z11=z1 then
                  begin
                    if random(2)=0 then z1:='S' else z1:='X';
                  end;
              End
              else


                           {prawo}
              if (z1='C')and((GetPixel(x1+5,y1)<16)or(x1+5>318)) then
              Begin
                  if (GetPixel(x1,y1+5)<16)or(y1+5>175) then z1:='S';
                  if (GetPixel(x1,y1-5)<16)or(y1-5<2) then z1:='X';
                  if z11=z1 then
                  begin
                    if random(2)=0 then z1:='S' else z1:='X';
                  end;

              End
              Else
              if komputer<99 then
              Begin
                xx:=Random(komputer+4);
                if (xx=0)and(z1<>'X')and(getPixel(x1,y1-5)>16)and(y1-5>2) then z1:='S';
                if (xx=1)and(z1<>'C')and(getPixel(x1-5,y1)>16)and(x1-5>2) then z1:='Z';
                if (xx=2)and(z1<>'S')and(getPixel(x1,y1+5)>16)and(y1+5<175) then z1:='X';
                if (xx=3)and(z1<>'Z')and(getPixel(x1+5,y1)>16)and(x1+5<318) then z1:='C';
              End;
{              if (z1='D')or(z1='G') then for i:=1 to 10 do dz;}



         end;


      end; {else czyli ruchy komputera}



    if (z1='S') then a:=12;
    if (z1='X') then a:=13;
    if (z1='Z') then a:=14;
    if (z1='C') then a:=15;
    RysCz(a*5+160,0,a*5+5+160,5,x1-2,y1-2,15);
{    RysCz(0,0,5,5,x1-2,y1-2,8);}




END;

until x>1000;
konP2:
x:=-99;

konP1:
if x=-99 then
  begin

    for i:=1 to punkty do
      begin
        WstawL(PGracz1+i,6+102+6,184,0);
       delay(300 div punkty);
      end;
      {WstawL(PGracz2,GetMaxX-11,184);}
      PGracz1:=PGracz1+punkty
  end
else
  begin
    if (lg=1)and(komputer=0) then
    begin
           punkty:=punkty div 2;
      for i:=1 to punkty do
      begin
       WstawL(PGracz1+i,114,184,0);

{              For i:=150 to 200 do}

{              sound(160);

              nosound;
       delay(300 div (punkty*2) );}
{            end;}
{            NoSound;}
       delay(300 div punkty);
       end;
      PGracz1:=PGracz1+punkty

    end
    else

    begin
   for i:=1 to punkty do
     begin
       WstawL(PGracz2+i,GetMaxX-11,184,0);
       delay(300 div punkty);
     end;
   PGracz2:=Pgracz2+punkty
   end;
end;

delay(500);
if keypressed then
repeat
  z:=readkey;
until not keypressed;
z:=readkey;
if z=#27 then goto ooo;
if zycia>1 then czysc(cz) else sciemnij(2);
if keypressed then
repeat
  z:=readkey;
until not keypressed;
{z:=readkey;}
if zycia>1 then goto goo;

wyniki(PGracz1,st);
if lg=2 then wyniki(PGracz2,st1);
PokazWyniki;

ooo:

end {go};


procedure demo;
var tab:array[0..64000]of byte;
begin
{  naEkran('emes01');}
{  dotablicy('emes01');}
  Assign(f,'dane.dat');
  Reset(f,1);
  Seek (f,64768*5);
  BlockRead(f,BMPPalette,256*3,wynik);
  SetPalette;
  BlockRead(f,tab,320*200,wynik);
  Close(f);
{  czarno;
  czysc(cz);
  setpalet  }
{  Memory := Ptr(Segment,0);}
{  Move (tablica,tab,320*100);}
{  setpalette;}



{  dz;}




  x:=200;
  For i:=0 to x do
Begin
  i:=i+5;

  Memory := Ptr (Segment,0);
{  x:=320*174-i*320;}
if i<x then  Move(Tab[320*x-i*320],memory^,320*x-(x-i)*320);
  if i>x then i:=x;
End;
  delay(1500);
  z:=readkey;


{readln;}

  czysc(4);

  z:='9';
end;
procedure demo1;
var tab:array[0..64000]of byte;
begin
{  naEkran('emes01');}
{  dotablicy('emes01');}
  Assign(f,'dane.dat');
  Reset(f,1);
  Seek (f,64768*4);
  BlockRead(f,BMPPalette,256*3,wynik);
  SetPalette;
  BlockRead(f,tab,320*200,wynik);
  Close(f);
{  czarno;
  czysc(cz);
  setpalet  }
{  Memory := Ptr(Segment,0);}
{  Move (tablica,tab,320*100);}
{  setpalette;}



{  dz;}




  x:=200;
  i:=-1;
  For ii:=0 to x+5 do
Begin
  i:=i+5;
{  if i>190 then i:=i-4;}

  Memory := Ptr (Segment,0);
{  x:=320*174-i*320;}
if i<x then  Move(Tab[320*x-i*320],memory^,320*x-(x-i)*320);
  if i>x then i:=x;
End;
  delay(500);
  if keypressed then
  repeat
   z:=readkey;
  until not keypressed;

  z:=readkey;


{readln;}

  czysc(cz);

  z:='9';
end;

function strz:boolean;
begin

if z=#27 then koniec:=true;
if (wybor=1)and((z=g)or(z=l)) then z:='@';
if (wybor=8)and((z=d)or(z=p)) then z:='@';
if (z=#27)or(z=g)or(z=d)or(z=l)or(z=p) then strz:=true
else strz:=false;

end;

{procedure ZKlaw;
Begin
  Repeat
    z:=readkey;
    if wybor=4 then
    begin
      if z='+' then szybkosc:=szybkosc+1;
      if z='-' then szybkosc:=szybkosc-1;
      WstawL(szybkosc,198-4,102,3);
    end;
  Until (z=#27)or(z=#13)or(z=g)or(z=d)or(z=l)or(z=p);
  if z=#27 then koniec:=true;
End;}



procedure poczatek;
begin
  doTablicyD(dan*12);
  naEkranD(0);
{  BMPPalette[255].green:=0;
  BMPPalette[255].blue:=0;
  BMPPalette[255].red:=0;}
  WstawT(st,55,53);
  WstawT(st1,186,53);
  WstawL(komputer,84-4,102,2);
  WstawL(szybkosc,198-4,102,3);
  WstawL(rozciag,258-4,102,2);
  SetPalette;
  txt:='Marcin Stefaniak';

{  kwadrat(50,39,136,66,15);


  readln;
  kwadrat(50,39,136,66,0);


  readln;

  z:=readkey;}
  if keypressed then
  repeat
    z:=readkey;
  until not keypressed;
  z:='3';
{  if wybor<7 then wybor:=7;}
  koniec:=false;
  start:=false;
  od_pocz:=false;
  Repeat
  if (z=d)or(z=p) then wybor:=wybor+1;
  if (z=g)or(z=l) then wybor:=wybor-1;
  if wybor>8 then wybor:=8;
  if wybor<1 then wybor:=1;
  case wybor  of
    1:Begin
        kwadrat(50,39,136,49,15);
        Repeat
          z:=readkey;
          if z=#13 then
            begin
              for i:=0 to 7 do st[i]:='.';
              wstawT(st,55,53);
              i:=0;
              Repeat

                z:=readkey;
                z:=UpCase(z);
                if z=#0 then begin z:='~';end;


                if ((Ord(z)>=65)and(Ord(z)<=90))or(z='.') then
                  begin
                    st[i]:=z;
                    if i<=7 then i:=i+1;
                    WstawT(st,55,53);
                  end;
                if z=#8 then
                  begin
                    if (i>0) then st[i-1]:='.';
                    st[i]:='.';
                    if (i>0) then i:=i-1;
                    WstawT(st,55,53);
                  end;


              Until (z=#13)or(z='~');
              z:='i';



            end;
        until strz;
        kwadrat(50,39,136,49,0);
      End;
    2:Begin
        kwadrat(181,39,267,49,15);
         Repeat
           z:=readkey;
           if z=#13 then
             begin
               for i:=0 to 7 do st1[i]:='.';
               wstawT(st1,186,53);
               i:=0;
               Repeat

                 z:=readkey;
                 z:=UpCase(z);
                 if z=#0 then begin z:='~';end;


                 if ((Ord(z)>=65)and(Ord(z)<=90))or(z='.') then
                   begin
                     st1[i]:=z;
                     if i<=7 then i:=i+1;
                     WstawT(st1,186,53);
                   end;
                 if z=#8 then
                   begin
                     if (i>0) then st1[i-1]:='.';
                     st1[i]:='.';
                     if (i>0) then i:=i-1;
                     WstawT(st1,186,53);
                   end;


               Until (z=#13)or(z='~');
               z:='i';



             end;
         until strz;
        kwadrat(181,39,267,49,0);
      End;
    3:Begin
        kwadrat(19,87,106,114,15);
        Repeat
          z:=readkey;
          if (z=#13)or(z='+') then komputer:=komputer+1;
          if z='-' then komputer:=komputer-1;
          if komputer=-1 then komputer:=99;
          if komputer=100 then komputer:=0;
          if (z=#13)or(z='+')or(z='-')then  WstawL(komputer,84-4,102,2);
        until strz;
        kwadrat(19,87,106,114,0);
      End;
    4:Begin
        kwadrat(132,87,211,114,15);
        Repeat
          z:=readkey;
          if (z=#13)or(z='+') then szybkosc:=szybkosc+1;
          if z='-' then szybkosc:=szybkosc-1;
          if szybkosc=-1 then szybkosc:=300;
          if szybkosc=301 then szybkosc:=0;
          if (z=#13)or(z='+')or(z='-')then   WstawL(szybkosc,198-4,102,3);
        until strz;
        kwadrat(132,87,211,114,0);
      End;
    5:Begin
        kwadrat(234,87,301,114,15);
        Repeat
          z:=readkey;
          if (z=#13)or(z='+') then rozciag:=rozciag+1;
          if z='-' then rozciag:=rozciag-1;
          if rozciag<0 then rozciag:=99;
          if rozciag=100 then rozciag:=0;
          if (z=#13)or(z='+')or(z='-')then WstawL(rozciag,258-4,102,2);
        until strz;
        kwadrat(234,87,301,114,0);
      End;
    6:Begin
        kwadrat(35,133,152,149,15);
        Repeat
          z:=readkey;
          if z=#13 then
          begin
          czysc(cz);
          pokazwyniki;
          czysc(cz);
          od_pocz:=true;
          end;
        until (strz)or(od_pocz);

        if not od_pocz then kwadrat(35,133,152,149,0);
      End;
    7:Begin
        kwadrat(105,171,170,186,15);
        Repeat
          z:=readkey;
        until (strz)or(z=#13);
        If z=#13 then begin start:=true;lg:=1;end;
        kwadrat(105,171,170,186,0);

      End;
    8:Begin
        kwadrat(196,171,261,186,15);
        Repeat
          z:=readkey;
        until (strz)or(z=#13);
        If z=#13 then begin start:=true;lg:=2;end;

        kwadrat(196,171,261,186,0);
      End;
    end;


  until (start)or(koniec)or(od_pocz);

  {czysc(1);}




end;





{****************************************************************************}
{****************************************************************************}
{****************************************************************************}
{****************************************************************************}

begin
txt:=' (C) 1995 by Emes Software ';
GetDate(d_r,d_m,d_d,d_dd);
Assign(fData,'data.eme');
Reset(fData);
Read(FData,dat);


lg:=1;

szyfr:=65;


if (d_r<>dat.r)or(d_m<>dat.m)or(d_d<>dat.d) then
begin
          Assign(ff1,'wyniki.eme');

          for ii:=0 to 9 do
          for i:=0 to 9 do df1.nazwa[ii][i]:=0-szyfr;
          for i:=0 to 9 do
          df1.sco[i]:=0;
          Rewrite(ff1);
          write(ff1,df1);
          close(ff1);
end;

Rewrite(fData);
dat.r:=d_r;
dat.m:=d_m;
dat.d:=d_d;
Write(fData,dat);
Close(fData);


{          kasownaie wynikow}
if ParamStr(1)='M.S.Emes' then
begin
          Assign(ff,'wije.eme');

          for ii:=0 to 9 do
          for i:=0 to 9 do df.nazwa[ii][i]:=0-szyfr;
          for i:=0 to 9 do
          df.sco[i]:=0;
          Rewrite(ff);

          write(ff,df);
          close(ff);
end;



randomize;
InitMode ($13);
{  InitVesaMode ($101);}
{St[0]:='M';
St[1]:='A';
St[2]:='R';
St[3]:=' ';
St[4]:='I';
St[5]:='N';
St[6]:='S';
St[7]:='T';

St1[0]:='S';
St1[1]:='T';
St1[2]:='E';
St1[3]:='F';
St1[4]:='A';
St1[5]:='N';
St1[6]:=' ';
St1[7]:=' ';
komputer:=5;
szybkosc:=250;
rozciag:=5; }
wybor:=7;

Assign(plik,'konifg.eme');
Reset(plik);
read(plik,dp);
DP.RAZ:=dp.raz+1;
rz:=dp.raz;
For i:=0 to 7 do
begin
  st[i]:=dp.st[i];
  st1[i]:=dp.st1[i];
end;
komputer:=dp.komputer;
szybkosc:=dp.szybkosc;
rozciag:=dp.rozciag;
Close(plik);









demo;
{goto end_gry;}
poczatek_gry:

{DDDDDDDDAAAAAAAAAANNNNNNNNEEEEEE}
{liczba graczy}
punkty:=0;





{goto end_gry;}

poczatek;

if od_pocz then goto poczatek_gry;



zycia:=6;

if start then
begin
  go;
  czysc(cz);
  goto poczatek_gry;
end;


end_gry:

      Assign(plik,'konifg.eme');
      Rewrite(plik);
      For i:=0 to 7 do
      begin
        dP.st[i]:=st[i];
        dP.st1[i]:=st1[i];
      end;
      dp.komputer:=komputer;
      dp.szybkosc:=szybkosc;
      dp.rozciag:=rozciag;
      Write(plik,dp);
      Close(plik);

Assign(pt,'konifg.eme');
Append(pt);
Write(pt,'-',rz,'<');
Close(pt);

{demo1;}
czysc(cz);
InitMode($03);
{GetDate(d_r,d_m,d_d,d_dd);
if (d_r>1995)and(d_m>1)then
begin}

emse[0]:='W' ;
emse[1]:='i';
emse[2]:='j';
emse[3]:='e';
emse[4]:=' ';
emse[5]:='v';
emse[6]:='1';
emse[7]:='.';
emse[8]:='0';
emse[9]:=' ';
emse[10]:=' ';
emse[11]:='a';
emse[12]:='u';
emse[13]:='t';
emse[14]:='o';
emse[15]:='r';
emse[16]:=':';
emse[17]:='M';
emse[18]:='a';
emse[19]:='r';
emse[20]:='c';
emse[21]:='i';
emse[22]:='n';
emse[23]:=' ';
emse[24]:='S';
emse[25]:='t';
emse[26]:='e';
emse[27]:='f';
emse[28]:='a';
emse[29]:='n';
emse[30]:='i';
emse[31]:='a';
emse[32]:='k';
emse[33]:=' ';
TextColor(3);
for i:=0 to 9 do Write(emse[i]);
TextColor(3);
for i:=10 to 33 do Write(emse[i]);
writeln;
writeln;



emse[0]:=' ';
emse[1]:='E';
emse[2]:='m';
emse[3]:='e';
emse[4]:='s';
emse[5]:=' ';
emse[6]:='S';
emse[7]:='o';
emse[8]:='f';
emse[9]:='t';
emse[10]:='w';
emse[11]:='a';
emse[12]:='r';
emse[13]:='e';
emse[14]:=' ';
emse[15]:=' ';
TextColor(lightgreen);
for i:=0 to 5 do Write(emse[i]);
TextColor(green);
for i:=5 to 15 do Write(emse[i]);
writeln;
TextColor(3);
emse[0]:='u';
emse[1]:='l';
emse[2]:='.';
emse[3]:='K';
emse[4]:='o';
emse[5]:='s';
emse[6]:='c';
emse[7]:='i';
emse[8]:='u';
emse[9]:='s';
emse[10]:='z';
emse[11]:='k';
emse[12]:='i';
emse[13]:=' ';
emse[14]:='4';
emse[15]:='8';
for i:=0 to 15 do Write(emse[i]);
writeln;
emse[0]:='0';
emse[1]:='8';
emse[2]:='-';
emse[3]:='1';
emse[4]:='1';
emse[5]:='2';
emse[6]:=' ';
emse[7]:='W';
emse[8]:='i';
emse[9]:='s';
emse[10]:='n';
emse[11]:='i';
emse[12]:='e';
emse[13]:='w';
emse[14]:=' ';
emse[15]:=' ';
write(' ');
for i:=0 to 15 do Write(emse[i]);
writeln;

writeln;
TextColor(7);
gracz1:='ul.Kosciuszki 48';
gracz1:='08-112 Wisniew';
delay(300);







end.
