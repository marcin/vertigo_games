unit Komputer;
{ modul gry komputera, do progamu Szewc }
{ autor: Marcin Beniamin Stefaniak      }

interface
uses typy;

procedure TuraKomputer(plansza:TPlansza;var x,y,k : integer);
{ ruch komputera - pobiera i zmienia wartosci x,y i k }
{ w zaleznosci od stanu "plansza"                     }

implementation

procedure wybierzPusta(var p:TPlansza;var a,b,c:integer);
{ wybranie ostatniej z wolnych krawedzi }
var i,j,k:integer;
begin
  for i:=1 to m do for j:=1 to n do for k:=1 to 2 do
    if p[i,j].pol[k]=nic then begin
      a:=i;b:=j;c:=k;
    end;
end;

procedure wybierzKrawedz(var pole:TPlansza;var i,j,k:integer);
{procdura wybier jedna z niezaznaczonych krawedzi na kwadracie}
begin
  {pisz('wyb kr',0);}
  if pole[i,j].pol[pionowa]=nic then k:=pionowa
  else if pole[i,j].pol[pozioma]=nic then k:=pozioma
  else if pole[tnij(i+1,m),j].pol[pozioma]=nic then begin
    i:=tnij(i+1,m);
    k:=pozioma;
  end else
  if pole[i,tnij(j+1,n)].pol[pionowa]=nic then begin
    j:=tnij(j+1,n);
    k:=pionowa;
  end;
end;

function KrawedzNieZaszkodzi(var p:TPlansza;i,j,k:integer):boolean;
{zwraca true jesli dostawienie tej krawedzi nie spowoduje punktu
dla przeciwnika}
begin
  if k=pozioma then
    if (kwadrat(p,tnij(i-1,m),j)<2)and(kwadrat(p,i,j)<2)
       then KrawedzNieZaszkodzi:=true
       else KrawedzNieZaszkodzi:=false
  {k=pionowa}else
    if (kwadrat(p,i,tnij(j-1,n))<2)and(kwadrat(p,i,j)<2)
      then KrawedzNieZaszkodzi:=true
      else KrawedzNieZaszkodzi:=false;
end;

procedure ruch(nr:integer;var i,j:integer);
{rusza i j wg numeracji:                                           }
{ numeracja:     1                                                 }
{              4 # 2                                               }
{                3                                                 }

begin
  case nr of
  1: i:=Tnij(i-1,m);
  2: j:=Tnij(j+1,n);
  3: i:=Tnij(i+1,m);
  4: j:=Tnij(j-1,n);
  end;
end;

function Pusty(var p:TPlansza;nr,i,j:integer):boolean;
{ funkcja zwraca true jesli bok numer "nr" kwadrtau i,j jest pusty }
{ numeracja:     1                                                 }
{              4 # 2                                               }
{                3                                                 }
begin
  case nr of
  1: begin pusty:= p[i,j].pol[pozioma]=nic;
     end;
  2: begin pusty:= p[i, tnij(j+1,n)].pol[pionowa]=nic;
     end;
  3: begin pusty:= p[tnij(i+1,m),j].pol[pozioma]=nic;
     end;
  4: begin pusty:= p[i,j].pol[pionowa]=nic;
     end;
  end;
end;

function NiemaKrawedziPomiedzy(var p:TPlansza;i,j,i1,j1:integer):boolean;
begin
  if Tnij(i+1,m)=i1 then NieMaKrawedziPomiedzy:=Pusty(p,3,i,j);
  if Tnij(i-1,m)=i1 then NieMaKrawedziPomiedzy:=Pusty(p,1,i,j);
  if Tnij(j+1,n)=j1 then NieMaKrawedziPomiedzy:=Pusty(p,2,i,j);
  if Tnij(j-1,n)=j1 then NieMaKrawedziPomiedzy:=Pusty(p,4,i,j);
end;

procedure WybierzKrawedzPomiedzy(var p:TPlansza;i1,j1,i2,j2:integer;var i,j,k:integer);
begin
  if Tnij(i1+1,m)=i2 then begin i:=i2;j:=j2;k:=pozioma end;
  if Tnij(i1-1,m)=i2 then begin i:=i1;j:=j1;k:=pozioma end;
  if Tnij(j1+1,m)=j2 then begin i:=i2;j:=j2;k:=pionowa end;
  if Tnij(j1-1,m)=j2 then begin i:=i1;j:=j1;k:=pionowa end;
end;



procedure AnalizaPlanszy(p:TPlansza;var ai,aj,ak:integer);
{analizuje plansze i wybiera najkorzystniejsze dla siebie krawedz}
var
  kw:array[1..zakres,1..zakres]of integer;{tablica ilosci zajetych krawedzi}
                                          {przy kwadracie i,j              }
  i,j,k:integer;

  ilosc,blokow,ii,jj,kk:integer;
  { blok to zbior sasiadujacych kwadratow takich ze mozna zajac je }
  { jednym ciagiem jesli ktos je napocznie                         }

  cykliczny :boolean;{czy blok jest cykliczny}

  napoczety:byte;{ilosc napoczec w bloku - napoczecie to kwadrat o }
                 { 3 krawedziach                                   }

  procedure podpucha(var p:TPlansza;i,j:integer);
  {jesli jest mozliwosc to komputer oddaje kilka pul co daje mu ostatecznie}
  {zwyciestwo                                                              }
  var a,b,nr:integer;
  begin
    for nr:=1 to 4 do begin
      a:=i;b:=j;
      ruch(nr,a,b);
      if niemaKrawedziPomiedzy(p,i,j,a,b) then begin

        if(kwadrat(p,a,b)<=2)then begin

          if(kwadrat(p,i,j)=2) then WybierzKrawedzPomiedzy(p,i,j,a,b,ii,jj,kk)
                               else podpucha(p,a,b);
         end;

      end;
    end;
  end;

  procedure blok(i,j:integer);
  {ustalanie blokow - tunelow}
  var nr,a,b:integer;
  begin
    kw[i,j]:=10+ilosc;

    ilosc:=ilosc+1;
    for nr:=1 to 4 do begin
      a:=i;b:=j;
      ruch(nr,a,b);
      if niemaKrawedziPomiedzy(p,i,j,a,b) then begin

        if (kw[a,b]>=10)and(kw[a,b]-kw[i,j]>1) then begin
          cykliczny:=true;
        end;
        if (Kw[a,b]=2) then begin

          if napoczety=0 then WybierzKrawedzPomiedzy(p,i,j,a,b,ii,jj,kk);
          blok(a,b);
        end;
        if (Kw[a,b]=3) then begin
          blok(a,b);

          if napoczety=0 then WybierzKrawedzPomiedzy(p,i,j,a,b,ii,jj,kk);
          inc(napoczety);
        end;

      end;
    end;
  end;

const
  nicniema=1000;
var
  {dane o najmniejszym napoczetym i nienapoczetynm bloku}
  blokNap,BlokNieNap:record
                       i,j,k:integer;
                       pol:integer;
                       cykl:boolean;
                       napoczec:integer
                     end;

  krawedzie:record {krawedzie "nie szkodzace}
              ilosc:integer;
              i,j,k:array[1..200]of integer;
            end;
 tmp,iloscNap,IloscNieNap,stracone,zyskane:integer;
 KoniecGry,zacznijAnalize:boolean;

begin
  ai:=0;aj:=0;ak:=0;

  iloscNap:=0;iloscNieNap:=0;
  koniecGry:=true;
  zacznijAnalize:=false;
  krawedzie.ilosc:=0;

  {uworzenie tablicy wolnych i nie powodujacych punktu dla przeciwnika      }
  {krawedzi co umozliwi lsowe wybranie jednej z nich (jesli takie istnieja) }
  { jesli jest ktawedz z 3 kawedziami to przystopimy do analizy}
  for i:=1 to m do for j:=1 to n do for k:=1 to 2 do begin
    if kwadrat(p,i,j)=3 then begin
        zacznijAnalize:=true;
      end;
    if (p[i,j].pol[k]=nic) then begin
      KoniecGry:=false;
      if krawedzNieZaszkodzi(p,i,j,k) then begin
        inc(krawedzie.ilosc);
        krawedzie.i[krawedzie.ilosc]:=i;
        krawedzie.j[krawedzie.ilosc]:=j;
        krawedzie.k[krawedzie.ilosc]:=k;
      end;
    end;
  end;

  if koniecGry then begin
    {jesli nie ma zadnej wolnej krawedzi}
    ai:=0;
  end else begin

    if (not zacznijAnalize) and (krawedzie.ilosc>0) then begin
     {jesli nie potrzecna jest analize (nie ma zadnego kwadratu o 3 krawdziach}
     {zajetych}
      tmp:=random(krawedzie.ilosc)+1;
      ai:=krawedzie.i[tmp];
      aj:=krawedzie.j[tmp];
      ak:=krawedzie.k[tmp];

    end else begin

      {analiza najleprzego wyboru bloku }

      {punkty stracone i zyskane dzieki wybirowi}
      Stracone:=0;
      Zyskane:=0;


      for i:=1 to m do for j:=1 to n do kw[i,j]:=kwadrat(p,i,j);
      {ustalwenie tablicy iosci zajetych krawedzi przy kwadratach}

      {inicjacja}
      blokow:=0;
      BlokNap.pol:=nicniema;
      BlokNieNap.pol:=nicniema;

      for i:=1 to m do for j:=1 to n do if (kw[i,j]=2)or(kw[i,j]=3) then begin

        ilosc:=0;
        cykliczny:=false;
        napoczety:=0;
        ii:=i;jj:=j;
        WybierzKrawedz(p,ii,jj,kk);
        if kw[i,j]=3 then begin
          napoczety:=1;
        end;
        blok(i,j);
        inc(blokow);
        {ustalenie czy oplaca sie robic podpuche}
        if napoczety=0 then begin
          if cykliczny then begin
            stracone:=stracone+4;
            zyskane:=zyskane+ilosc-4;
          end else begin
            stracone:=stracone+2;
            zyskane:=zyskane+ilosc-2;
          end;

        end;

        if napoczety>0 then begin
          inc(iloscNap);
          {najmniejszy blok napoczety}
          if BlokNap.pol>ilosc then begin
             BlokNap.pol:=ilosc;
             BlokNap.i:=ii;BlokNap.j:=jj;BlokNap.k:=kk;
             BlokNap.cykl:=cykliczny;
             BlokNap.napoczec:=napoczety;

          end
        end
        else begin
          inc(iloscNieNap);

          {najmniejszy blok nienapoczety}
          if (BlokNieNap.pol>ilosc)then begin
             BlokNieNap.pol:=ilosc;
             BlokNieNap.i:=ii;BlokNieNap.j:=jj;BlokNieNap.k:=kk;
             BlokNieNap.cykl:=cykliczny;
          end
        end;
      end; {analiza blokown (for)}

      zyskane:=zyskane+2;

      {warunki na dobra podpuche}
      if (zyskane>stracone) and
         ( ((BlokNap.pol=2)and(BlokNap.napoczec=1))
         or ((BlokNap.pol=4)and(BlokNap.napoczec=2)) )

        and (blokow>1) and (iloscNap=1) and

        ( ((BlokNieNap.pol>2)and(not BlokNieNap.cykl)) or

         ((BlokNieNap.pol>3)and(BlokNieNap.cykl))  )

      then begin
            podpucha(p,BlokNap.i,BlokNap.j);
            ai:=ii;aj:=jj;ak:=kk;

      end else begin
        {wybranie najmniejszego bloku - napoczety ma pierwszenstwo bo my go }
        {zajmniemy                                                          }
        if BlokNap.pol<>nicniema then begin
          ai:=BlokNap.i;aj:=BlokNap.j;ak:=BlokNap.k;
        end else begin
          ai:=BlokNieNap.i;aj:=BlokNieNap.j;ak:=BlokNieNap.k;
        end;

      end;

      if p[ai,aj].pol[ak]<>nic then begin
        {czasem nie da sie zrobic podpuchy}
        wybierzPusta(p,ai,aj,ak);
      end;

   end;{anializa blokow}

 end;{koniec gry}
end;{analiza}

function punkty(p:TPlansza;i,j,k:integer):byte;
var
  pkt:byte;

begin
  pkt:=0;

  if i>0 then begin

   p[i,j].pol[k]:=nic;
    if (kwadrat(p,i,j)=3)
         then begin
           inc(pkt);
         end;

    if (k=pozioma) then begin
    if m=1 then begin
      if kwadrat(p,i,j)=2 then begin
        inc(pkt);
      end;
    end else begin
      i:=tnij(i-1,m);
      if kwadrat(p,i,j)=3 then begin
        inc(pkt);
      end;
    end;
    end;

    if (k=pionowa) then begin
      if n=1 then begin
        if kwadrat(p,i,j)=2 then begin
          inc(pkt);
        end;
      end else begin
        j:=tnij(j-1,n);
        if kwadrat(p,i,j)=3 then begin
        inc(pkt);
        end
      end;
    end;
  end;
  punkty:=pkt;
end;{analiza planszy}

procedure TuraKomputer(plansza:TPlansza;var x,y,k:integer);
begin
  if punkty(plansza,x,y,k)>0 then begin
  {jesli przeciwnik zdobyl punkt to pasowanie}
    x:=0;y:=0;k:=0;
  end else AnalizaPlanszy(plansza,x,y,k);
end;


end.
