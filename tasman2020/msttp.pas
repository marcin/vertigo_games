unit msttp;
interface
uses graph,dos;
Procedure mst_save(nazwa_ml:string;
                   px_ms1,py_ms1,px_ms,py_ms:longint);
Procedure mst_load(nazwa_ml:string;
                   px_ml1,py_ml1:word);
Procedure m_save(nazwa_ml:string;
          px_ms1,py_ms1,px_ms,py_ms:longint);
Procedure m_load(nazwa_ml:string;
           px_ml1,py_ml1:word);

procedure load_tga(nazwa_eps:string;
                   EPS_X,EPS_Y:WORD);

Procedure mst_odczyt(nazwa_ml,nazwa_ms:string;
           px_ml1,py_ml1:word);
implementation

{     var sterownik,tryb:integer;
     z:char;}


Procedure mst_save(nazwa_ml:string;
                   px_ms1,py_ms1,px_ms,py_ms:longint);
          var mst_ver:string[12];
              mst_kolor_txt,k_:string[1];
              stary_kolor,pamie,pamie_czy,mst_kolor,ii_ml,px_ml,py_ml:longint;
              kod_val:integer;
              nazwa_mst:string[8];
              nazwa_mst_c:string[12];
              plik_ms:text;
              i_mst:longint;

              zle_i :longint;
              czy_kolor{pm1,pm2,pm3}:string[2];

          begin
            nazwa_mst:=nazwa_ml;
            nazwa_mst_c:=nazwa_mst+'.mst';;

            Assign(plik_ms,nazwa_mst_c);
            Rewrite(plik_ms);

            Write(plik_ms,'MSt VertigO ');
            Write(plik_ms,px_ms,' ');
            Write(plik_ms,py_ms,' ');


            px_ml:=px_ms1-1;
            py_ml:=py_ms1;
            ii_ml:=0;
            pamie:=0;
            pamie_czy:=1;
              {zapisywanie do plik_msu}
              For i_mst:=1 to px_ms*py_ms do
              begin

                stary_kolor:=GetPixel(px_ml,py_ml);
                px_ml:=px_ml+1;
                ii_ml:=ii_ml+1;

                if ii_ml=px_ms+1 then
                begin
                  ii_ml:=1;
                  px_ml:=px_ms1;
                  py_ml:=py_ml+1;
                end;

                mst_kolor:=GetPixel(px_ml,py_ml);

                if (i_mst>1)and(stary_kolor=mst_kolor)then
                begin
                  pamie:=pamie+1;
                end;


                if (pamie>0) and (stary_kolor<>mst_kolor)then
                begin
                 if pamie<3 then
                 begin
                   if pamie=1 then write(plik_ms,mst_kolor_txt);
                   if pamie=2 then write(plik_ms,mst_kolor_txt,mst_kolor_txt);
                 end
                 else
                 begin
                  if (pamie>0)and      (pamie<10) then write(plik_ms,'p');
                  if (pamie>9)and      (pamie<100) then write(plik_ms,'r');
                  if (pamie>99)and     (pamie<1000) then write(plik_ms,'s');
                  if (pamie>999)and    (pamie<10000) then write(plik_ms,'t');
                  if (pamie>9999)and   (pamie<100000) then write(plik_ms,'u');
                  if (pamie>99999)and  (pamie<1000000) then write(plik_ms,'w');
                  if (pamie>999999)and (pamie<10000000) then write(plik_ms,'x');
                  if (pamie>9999999)and(pamie<100000000) then write(plik_ms,'y');
                  write(plik_ms,pamie);
                 end;
                 pamie:=0;
                 pamie_czy:=1;
                end;
                if pamie=0 then
                begin
                  if mst_kolor<10 then Str(mst_kolor,mst_kolor_txt);
                  if mst_kolor=10 then mst_kolor_txt:='a';
                  if mst_kolor=11 then mst_kolor_txt:='b';
                  if mst_kolor=12 then mst_kolor_txt:='c';
                  if mst_kolor=13 then mst_kolor_txt:='d';
                  if mst_kolor=14 then mst_kolor_txt:='e';
                  if mst_kolor=15 then mst_kolor_txt:='f';
                  Write(plik_ms,mst_kolor_txt);
                end;
          {      if (i=poziom*pion)and(i>0)then write(plik_ms,'p',pamie);   !!!!!!!!!!!!!!!!!!}
              end;
              Writeln(plik_ms);
              Write(plik_ms);
              Close(plik_ms);
          end;{mst na plik_ms}






Procedure mst_load(nazwa_ml:string;
                   px_ml1,py_ml1:word);
          var mst_ver:string[12];
              mst_kolor_txt,k_:string[1];
              stary_kolor,pamie,mst_kolor,ii_ml,px_ml,py_ml,poziom_l,pion_l:longint;
              kod_val:integer;
              nazwa_mst:string[8];
              nazwa_mst_c:string[12];
              pp_:string[1];
              rr_:string[2];
              ss_:string[3];
              tt_:string[4];
              uu_:string[5];
              ww_:string[6];
              plik_ms:text;
              i_mst:longint;
                {jest tylko do miliona !!!!!!!!!!!!!!!
                   if (pamie>0)and      (pamie<10) then write(plik_ms,'p');
                    if (pamie>9)and      (pamie<100) then write(plik_ms,'r');
                    if (pamie>99)and     (pamie<1000) then write(plik_ms,'s');
                    if (pamie>999)and    (pamie<10000) then write(plik_ms,'t');
                    if (pamie>9999)and   (pamie<100000) then write(plik_ms,'u');
                    if (pamie>99999)and  (pamie<1000000) then write(plik_ms,'w');
                    if (pamie>999999)and (pamie<10000000) then write(plik_ms,'x');
                    if (pamie>9999999)and(pamie<100000000) then write(plik_ms,'y');}
          begin
            nazwa_mst:=nazwa_ml;
            nazwa_mst_c:=nazwa_mst+'.mst';

            Assign(plik_ms,nazwa_mst_c);
            Reset(plik_ms);
            Read(plik_ms,mst_ver,poziom_l,pion_l,mst_kolor_txt);

            px_ml:=px_ml1-1;
            py_ml:=py_ml1;
            ii_ml:=0;
            pamie:=1;
              {loadowanie MST z plik_msu}
              if mst_ver='MSt VertigO ' then
              For i_mst:=1 to poziom_l*pion_l do
              begin
                px_ml:=px_ml+1;
                ii_ml:=ii_ml+1;
                if ii_ml=poziom_l+1 then
                begin
                  ii_ml:=1;
                  px_ml:=px_ml1;
                  py_ml:=py_ml+1;
                end;
                if pamie>1 then pamie:=pamie-1;
                if pamie=1 then
                begin
                  Read(plik_ms,mst_kolor_txt);
                  if mst_kolor_txt='0' then mst_kolor:=0;
                  if mst_kolor_txt='1' then mst_kolor:=1;
                  if mst_kolor_txt='2' then mst_kolor:=2;
                  if mst_kolor_txt='3' then mst_kolor:=3;
                  if mst_kolor_txt='4' then mst_kolor:=4;
                  if mst_kolor_txt='5' then mst_kolor:=5;
                  if mst_kolor_txt='6' then mst_kolor:=6;
                  if mst_kolor_txt='7' then mst_kolor:=7;


                  if mst_kolor_txt='8' then mst_kolor:=8;
                  if mst_kolor_txt='9' then mst_kolor:=9;
                  if mst_kolor_txt='a' then mst_kolor:=10;
                  if mst_kolor_txt='b' then mst_kolor:=11;
                  if mst_kolor_txt='c' then mst_kolor:=12;
                  if mst_kolor_txt='d' then mst_kolor:=13;
                  if mst_kolor_txt='e' then mst_kolor:=14;
                  if mst_kolor_txt='f' then mst_kolor:=15;

                  if mst_kolor_txt='p' then begin read(plik_ms,pp_);Val(pp_,pamie,kod_val);end;
                  if mst_kolor_txt='r' then begin read(plik_ms,rr_);Val(rr_,pamie,kod_val);end;
                  if mst_kolor_txt='s' then begin read(plik_ms,ss_);val(ss_,pamie,kod_val);end;
                  if mst_kolor_txt='t' then begin read(plik_ms,tt_);val(tt_,pamie,kod_val);end;
                  if mst_kolor_txt='u' then begin read(plik_ms,uu_);val(uu_,pamie,kod_val);end;
                  if mst_kolor_txt='w' then begin read(plik_ms,ww_);val(ww_,pamie,kod_val);end;
                  if pamie>0 then pamie:=pamie+1;
                end;
                PutPixel(px_ml,py_ml,mst_kolor);
              end;
              Close(plik_ms);

          end;{mst_load}




                               Procedure m_save(nazwa_ml:string;
                                                  px_ms1,py_ms1,px_ms,py_ms:longint);
                                         var mst_ver:string[12];
                                             mst_kolor_txt,k_:string[1];
                                             stary_kolor,pamie,pamie_czy,mst_kolor,ii_ml,px_ml,py_ml:longint;
                                             kod_val:integer;
                                             nazwa_mst:string[8];
                                             nazwa_mst_c:string[12];
                                             plik_ms:text;
                                             i_mst:longint;

                                             zle_i :longint;
                                             czy_kolor{pm1,pm2,pm3}:string[2];

                                         begin
                                           nazwa_mst:=nazwa_ml;
                                           nazwa_mst_c:=nazwa_mst+'.mst';;

                                           Assign(plik_ms,nazwa_mst_c);
                                           Rewrite(plik_ms);

                                           Write(plik_ms,'MSt VertigO ');
                                           Write(plik_ms,px_ms,' ');
                                           Write(plik_ms,py_ms,' ');


                                           px_ml:=px_ms1-1;
                                           py_ml:=py_ms1;
                                           ii_ml:=0;
                                           pamie:=0;
                                           pamie_czy:=1;
                                             {zapisywanie do plik_msu}
                                             For i_mst:=1 to px_ms*py_ms do
                                             begin

                                              { stary_kolor:=GetPixel(px_ml,py_ml);}
                                               px_ml:=px_ml+1;
                                               ii_ml:=ii_ml+1;

                                               if ii_ml=px_ms+1 then
                                               begin
                                                 ii_ml:=1;
                                                 px_ml:=px_ms1;
                                                 py_ml:=py_ml+1;
                                               end;

                                               mst_kolor:=GetPixel(px_ml,py_ml);
                                              write(plik_ms,mst_kolor,' ');
                                             end;

                                               {if (i_mst>1)and(stary_kolor=mst_kolor)then
                                               begin
                                                 pamie:=pamie+1;
                                               end;}


                                               {if (pamie>0) and (stary_kolor<>mst_kolor)then
                                               begin
                                                if pamie<3 then
                                                begin
                                                  if pamie=1 then write(plik_ms,mst_kolor_txt);
                                                  if pamie=2 then write(plik_ms,mst_kolor_txt,mst_kolor_txt);
                                                end
                                                else
                                                begin
                                                 if (pamie>0)and      (pamie<10) then write(plik_ms,'p');
                                                 if (pamie>9)and      (pamie<100) then write(plik_ms,'r');
                                                 if (pamie>99)and     (pamie<1000) then write(plik_ms,'s');
                                                 if (pamie>999)and    (pamie<10000) then write(plik_ms,'t');
                                                 if (pamie>9999)and   (pamie<100000) then write(plik_ms,'u');
                                                 if (pamie>99999)and  (pamie<1000000) then write(plik_ms,'w');
                                                 if (pamie>999999)and (pamie<10000000) then write(plik_ms,'x');
                                                 if (pamie>9999999)and(pamie<100000000) then write(plik_ms,'y');
                                                 write(plik_ms,pamie);
                                                end;
                                                pamie:=0;
                                                pamie_czy:=1;
                                               end;
                                               if pamie=0 then
                                               begin
                                                 if mst_kolor<10 then Str(mst_kolor,mst_kolor_txt);
                                                 if mst_kolor=10 then mst_kolor_txt:='a';
                                                 if mst_kolor=11 then mst_kolor_txt:='b';
                                                 if mst_kolor=12 then mst_kolor_txt:='c';
                                                 if mst_kolor=13 then mst_kolor_txt:='d';
                                                 if mst_kolor=14 then mst_kolor_txt:='e';
                                                 if mst_kolor=15 then mst_kolor_txt:='f';
                                             Write(plik_ms,mst_kolor_txt);}
{                                               end;
                                              if (i=poziom*pion)and(i>0)then write(plik_ms,'p',pamie);   !!!!!!!!!!!!!!!!!!
                                             end;}
                                             Writeln(plik_ms);
                                             Write(plik_ms);
                                             Close(plik_ms);
                                         end;{mst na plik_ms}






                               Procedure m_load(nazwa_ml:string;
                                                  px_ml1,py_ml1:word);
                                         var mst_ver:string[12];
                                             mst_kolor_txt,k_:string[1];
                                             stary_kolor,pamie,mst_kolor,ii_ml,px_ml,py_ml,poziom_l,pion_l:longint;
                                             m_kolor:word;
                                             kod_val:integer;
                                             nazwa_mst:string[8];
                                             nazwa_mst_c:string[12];
                                             pp_:string[1];
                                             rr_:string[2];
                                             ss_:string[3];
                                             tt_:string[4];
                                             uu_:string[5];
                                             ww_:string[6];
                                             plik_ms:text;
                                             i_mst:longint;
                                               {jest tylko do miliona !!!!!!!!!!!!!!!
                                                  if (pamie>0)and      (pamie<10) then write(plik_ms,'p');
                                                   if (pamie>9)and      (pamie<100) then write(plik_ms,'r');
                                                   if (pamie>99)and     (pamie<1000) then write(plik_ms,'s');
                                                   if (pamie>999)and    (pamie<10000) then write(plik_ms,'t');
                                                   if (pamie>9999)and   (pamie<100000) then write(plik_ms,'u');
                                                   if (pamie>99999)and  (pamie<1000000) then write(plik_ms,'w');
                                                   if (pamie>999999)and (pamie<10000000) then write(plik_ms,'x');
                                                   if (pamie>9999999)and(pamie<100000000) then write(plik_ms,'y');}
                                         begin
                                           nazwa_mst:=nazwa_ml;
                                           nazwa_mst_c:=nazwa_mst+'.mst';

                                           Assign(plik_ms,nazwa_mst_c);
                                           Reset(plik_ms);
                                           Read(plik_ms,mst_ver,poziom_l,pion_l,mst_kolor_txt);

                                           px_ml:=px_ml1-1;
                                           py_ml:=py_ml1;
                                           ii_ml:=0;
                                           pamie:=1;
                                             {loadowanie MST z plik_msu}
                                             if mst_ver='MSt VertigO ' then
                                             For i_mst:=1 to poziom_l*pion_l do
                                             begin
                                               px_ml:=px_ml+1;
                                               ii_ml:=ii_ml+1;
                                               if ii_ml=poziom_l+1 then
                                               begin
                                                 ii_ml:=1;
                                                 px_ml:=px_ml1;
                                                 py_ml:=py_ml+1;
                                               end;
                                             {  if pamie>1 then pamie:=pamie-1;
                                               if pamie=1 then
                                               begin}
                                                 Read(plik_ms,m_kolor);
                                                { if mst_kolor_txt='0' then mst_kolor:=0;
                                                 if mst_kolor_txt='1' then mst_kolor:=1;
                                                 if mst_kolor_txt='2' then mst_kolor:=2;
                                                 if mst_kolor_txt='3' then mst_kolor:=3;
                                                 if mst_kolor_txt='4' then mst_kolor:=4;
                                                 if mst_kolor_txt='5' then mst_kolor:=5;
                                                 if mst_kolor_txt='6' then mst_kolor:=6;
                                                 if mst_kolor_txt='7' then mst_kolor:=7;


                                                 if mst_kolor_txt='8' then mst_kolor:=8;
                                                 if mst_kolor_txt='9' then mst_kolor:=9;
                                                 if mst_kolor_txt='a' then mst_kolor:=10;
                                                 if mst_kolor_txt='b' then mst_kolor:=11;
                                                 if mst_kolor_txt='c' then mst_kolor:=12;
                                                 if mst_kolor_txt='d' then mst_kolor:=13;
                                                 if mst_kolor_txt='e' then mst_kolor:=14;
                                                 if mst_kolor_txt='f' then mst_kolor:=15;

                                                 if mst_kolor_txt='p' then begin read(plik_ms,pp_);Val(pp_,pamie,kod_val);end;
                                                 if mst_kolor_txt='r' then begin read(plik_ms,rr_);Val(rr_,pamie,kod_val);end;
                                                 if mst_kolor_txt='s' then begin read(plik_ms,ss_);val(ss_,pamie,kod_val);end;
                                                 if mst_kolor_txt='t' then begin read(plik_ms,tt_);val(tt_,pamie,kod_val);end;
                                                 if mst_kolor_txt='u' then begin read(plik_ms,uu_);val(uu_,pamie,kod_val);end;
                                                 if mst_kolor_txt='w' then begin read(plik_ms,ww_);val(ww_,pamie,kod_val);end;
                                                 if pamie>0 then pamie:=pamie+1;
                                               end;}
                                               PutPixel(px_ml,py_ml,m_kolor);
                                               end;
                                             {end;}
                                             Close(plik_ms);

                                         end;{mst_load}


procedure load_tga(nazwa_eps:string;
                   EPS_X,EPS_Y:WORD);
          var
               plik_eps:text;
               i_eps,y_eps,x_eps,m_eps,ms_eps:integer;
               kolor_eps:string[1];
               k_eps:integer;
               k_b_eps:integer;





          begin

            nazwa_eps:=nazwa_eps+'.tga';

            Assign(plik_eps,nazwa_eps);
            Reset(plik_eps);
            For i_eps:=1 to 787 do
            read(plik_eps,kolor_eps);
            i_eps:=-1;
            y_eps:=1;
            m_eps:=0;
            k_eps:=14;
            ms_eps:=0;
            Repeat
              Repeat
                read(plik_eps,kolor_eps);
{                val(kolor_eps,k_eps,k_b_eps);}

                if kolor_eps=#0 then k_eps:=0;
                if kolor_eps=#1 then k_eps:=1;
                if kolor_eps=#2 then k_eps:=2;
                if kolor_eps=#3 then k_eps:=3;
                if kolor_eps=#4 then k_eps:=4;
                if kolor_eps=#5 then k_eps:=5;
                if kolor_eps=#6 then k_eps:=6;
                if kolor_eps=#7 then k_eps:=7;
                if kolor_eps=#8 then k_eps:=8;
                if kolor_eps=#9 then k_eps:=9;
                if kolor_eps=#10 then k_eps:=10;
                if kolor_eps=#11 then k_eps:=11;
                if kolor_eps=#12 then k_eps:=12;
                if kolor_eps=#13 then k_eps:=13;
                if kolor_eps=#14 then k_eps:=14;
                if kolor_eps=#15 then k_eps:=15;
                x_eps:=x_eps+1;
                PutPixel(x_eps,y_eps,k_eps);
                ms_eps:=ms_eps+1;
              Until ms_eps>EPS_X-1;
              ms_eps:=0;
              y_eps:=y_eps+1;
              x_eps:=1;
              m_eps:=m_eps+1;
            Until (kolor_eps=' ')or(m_eps>EPS_Y-1);

            close(plik_eps);
         end; {load_eps}

{Begin
  sterownik:=vga;
  tryb:=vgahi;
  initgraph(sterownik,tryb,'c:\tp\bgi');
  load_eps('winooo',320,240);}

{  M_SAVE('wino',1,1,320,240);

  z:=readkey;
  m_load('wino',300,300);

{    mst_load('zamek',1,1);
    mst_load('zamek',32,33);
      mst_load('zamek',1,33);}
{    repeat
  until keypressed;
  closegraph;}

Procedure mst_odczyt(nazwa_ml,nazwa_ms:string;
                   px_ml1,py_ml1:word);
          var mst_ver:string[12];
              mst_kolor_txt,k_:string[1];
              stary_kolor,pamie,mst_kolor,ii_ml,px_ml,py_ml,poziom_l,pion_l:longint;
              kod_val:integer;
              nazwa_mst:string[8];
              nazwa_mst_c:string[12];
              pp_:string[1];
              rr_:string[2];
              ss_:string[3];
              tt_:string[4];
              uu_:string[5];
              ww_:string[6];
              czy_nazwa:string[20];
              plik_ms,level:text;
              i_mst:longint;
                {jest tylko do miliona !!!!!!!!!!!!!!!
                   if (pamie>0)and      (pamie<10) then write(plik_ms,'p');
                    if (pamie>9)and      (pamie<100) then write(plik_ms,'r');
                    if (pamie>99)and     (pamie<1000) then write(plik_ms,'s');
                    if (pamie>999)and    (pamie<10000) then write(plik_ms,'t');
                    if (pamie>9999)and   (pamie<100000) then write(plik_ms,'u');
                    if (pamie>99999)and  (pamie<1000000) then write(plik_ms,'w');
                    if (pamie>999999)and (pamie<10000000) then write(plik_ms,'x');
                    if (pamie>9999999)and(pamie<100000000) then write(plik_ms,'y');}
          begin
            nazwa_mst:=nazwa_ml;
            nazwa_mst_c:=nazwa_mst+'.mst';

            Assign(plik_ms,nazwa_mst_c);
            Reset(plik_ms);

            Repeat
              readln(plik_ms,czy_nazwa);
            Until (czy_nazwa=nazwa_ms) or (eof(plik_ms));
            if eof(plik_ms) then halt;
            Read(plik_ms,mst_ver,poziom_l,pion_l,mst_kolor_txt);

            px_ml:=px_ml1-1;
            py_ml:=py_ml1;
            ii_ml:=0;
            pamie:=1;
              {loadowanie MST z plik_msu}
              if mst_ver='MSt VertigO ' then
              For i_mst:=1 to poziom_l*pion_l do
              begin
                px_ml:=px_ml+1;
                ii_ml:=ii_ml+1;
                if ii_ml=poziom_l+1 then
                begin
                  ii_ml:=1;
                  px_ml:=px_ml1;
                  py_ml:=py_ml+1;
                end;
                if pamie>1 then pamie:=pamie-1;
                if pamie=1 then
                begin
                  Read(plik_ms,mst_kolor_txt);
                  if mst_kolor_txt='0' then mst_kolor:=0;
                  if mst_kolor_txt='1' then mst_kolor:=1;
                  if mst_kolor_txt='2' then mst_kolor:=2;
                  if mst_kolor_txt='3' then mst_kolor:=3;
                  if mst_kolor_txt='4' then mst_kolor:=4;
                  if mst_kolor_txt='5' then mst_kolor:=5;
                  if mst_kolor_txt='6' then mst_kolor:=6;
                  if mst_kolor_txt='7' then mst_kolor:=7;


                  if mst_kolor_txt='8' then mst_kolor:=8;
                  if mst_kolor_txt='9' then mst_kolor:=9;
                  if mst_kolor_txt='a' then mst_kolor:=10;
                  if mst_kolor_txt='b' then mst_kolor:=11;
                  if mst_kolor_txt='c' then mst_kolor:=12;
                  if mst_kolor_txt='d' then mst_kolor:=13;
                  if mst_kolor_txt='e' then mst_kolor:=14;
                  if mst_kolor_txt='f' then mst_kolor:=15;

                  if mst_kolor_txt='p' then begin read(plik_ms,pp_);Val(pp_,pamie,kod_val);end;
                  if mst_kolor_txt='r' then begin read(plik_ms,rr_);Val(rr_,pamie,kod_val);end;
                  if mst_kolor_txt='s' then begin read(plik_ms,ss_);val(ss_,pamie,kod_val);end;
                  if mst_kolor_txt='t' then begin read(plik_ms,tt_);val(tt_,pamie,kod_val);end;
                  if mst_kolor_txt='u' then begin read(plik_ms,uu_);val(uu_,pamie,kod_val);end;
                  if mst_kolor_txt='w' then begin read(plik_ms,ww_);val(ww_,pamie,kod_val);end;
                  if pamie>0 then pamie:=pamie+1;
                end;
                PutPixel(px_ml,py_ml,mst_kolor);
              end;
              Close(plik_ms);

          end;{mst_odczyt}


end.