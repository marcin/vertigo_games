require 'ruby2d'

COLORS = {
  0   => 'black', #000000
  1   => 'blue', #0000AA
  2   => 'green', #00AA00
  3   => '#00AAAA', #'cyan',
  4   => 'red', #AA0000
  5   => 'magenta', #AA00AA
  6   => 'brown', #AA5500
  7   => '#AAAAAA', #'light gray',
  8   => '#555555', #'dark gray'
  9   => '#5555FF', #'light blue'
  10  => '#55FF55', #'light green'
  11  => '#55FFFF', #'light cyan',
  12  => '#FF5555', #'light red',
  13  => '#FF55FF', #'light magenta',
  14  => 'yellow', #FFFF55
  15  => 'white', #FFFFFF
}


def mst_load(nazwa_ml, px_ml1, py_ml1)
  nazwa_mst = nazwa_ml
  nazwa_mst_c = nazwa_mst+'.mst'

  file_name = "tas"
  f = File.open("../Tasman/#{file_name.upcase}.MST")
  tab = f.read.split(' ')
  mst_ver = "#{tab[0]} #{tab[1]}"
  poziom_l = tab[2].to_i
  pion_l = tab[3].to_i

  puts "mst_ver:#{mst_ver} poziom_l:#{poziom_l} pion_l:#{pion_l}"

  px_ml = px_ml1-1
  py_ml = py_ml1
  ii_ml = 0
  pamie = 1

  i = 0
  iii = 0
  colors = tab[4]
    # {loadowanie MST z plik_msu}
  if mst_ver == 'MSt VertigO'
    for i_mst in 1 .. poziom_l*pion_l do
      px_ml = px_ml+1
      ii_ml = ii_ml+1
      if ii_ml == poziom_l+1
        ii_ml = 1
        px_ml = px_ml1
        py_ml = py_ml+1
      end
      if pamie > 1
        pamie = pamie-1
      end
      if pamie == 1
        # Read(plik_ms,mst_kolor_txt)
        mst_kolor_txt = colors[i]

        return if mst_kolor_txt == nil
        i += 1
        puts "mst_kolor_txt: #{mst_kolor_txt}"
        mst_kolor = 0 if mst_kolor_txt == '0'
        mst_kolor = 1 if mst_kolor_txt == '1'
        mst_kolor = 2 if mst_kolor_txt == '2'
        mst_kolor = 3 if mst_kolor_txt == '3'
        mst_kolor = 4 if mst_kolor_txt == '4'
        mst_kolor = 5 if mst_kolor_txt == '5'
        mst_kolor = 6 if mst_kolor_txt == '6'
        mst_kolor = 7 if mst_kolor_txt == '7'


        mst_kolor = 8 if mst_kolor_txt  == '8'
        mst_kolor = 9 if mst_kolor_txt  == '9'
        mst_kolor = 10 if mst_kolor_txt == 'a'
        mst_kolor = 11 if mst_kolor_txt == 'b'
        mst_kolor = 12 if mst_kolor_txt == 'c'
        mst_kolor = 13 if mst_kolor_txt == 'd'
        mst_kolor = 14 if mst_kolor_txt == 'e'
        mst_kolor = 15 if mst_kolor_txt == 'f'


        digits = {p: 1, r: 2, s: 3, t: 4, u: 5, w: 6, x: 7, y: 8}
        if digits.keys.include?(mst_kolor_txt.to_sym)
          d = digits[mst_kolor_txt.to_sym]
          number = ''
          for j in 0 .. d - 1
            number += colors[i]
            i += 1
          end
          pamie = number.to_i
          puts "d: #{d} number: #{number}"
        end

        # xxx = 1
        # if mst_kolor_txt == 'p'
        #   i += xxx
        #   pamie += xxx
        #   # read(plik_ms,pp_)
        #   # Val(pp_,pamie,kod_val)
        # end
        # if mst_kolor_txt == 'r'
        #   i += xxx+1
        #   pamie += xxx+1
        #   # read(plik_ms,rr_)
        #   # Val(rr_,pamie,kod_val)
        # end
        # if mst_kolor_txt == 's'
        #   i += xxx+2
        #   pamie += xxx+2
        #   # read(plik_ms,ss_)
        #   # val(ss_,pamie,kod_val)
        # end
        # if mst_kolor_txt == 't'
        #   i += xxx+3
        #   pamie += xxx+3
        #   # read(plik_ms,tt_)
        #   # val(tt_,pamie,kod_val)
        # end
        # if mst_kolor_txt == 'u'
        #   i += xxx+4
        #   pamie += xxx+4
        #   # read(plik_ms,uu_)
        #   # val(uu_,pamie,kod_val)
        # end
        # if mst_kolor_txt == 'w'
        #   i += xxx+5
        #   pamie += xxx+5
        #   # read(plik_ms,ww_)
        #   # val(ww_,pamie,kod_val)
        # end
        if pamie > 0
          pamie = pamie+1
        end
      end
      iii += 1
      puts "PutPixel(#{px_ml}, #{py_ml}, #{mst_kolor}) i: #{i} / #{colors.size} poziom_l*pion_l: #{poziom_l*pion_l} iii: #{iii}"
      size = 1
      s = Square.new(x: px_ml*size, y: py_ml*size, size: size)
      s.color = COLORS[mst_kolor.to_i]

      # return if i > 20
    end # for
  end # if
  #   Close(plik_ms)
end

set width: 1000, height: 1000
#     s.color = colors[color]
mst_load('mst', 0, 0)
show
