COLORS = {
  0   => '#000000', #'black',
  1   => '#0000AA', # 'blue',
  2   => '#00AA00', #'green',
  3   => '#00AAAA', #'cyan',
  4   => '#AA0000', # 'red',
  5   => '#AA00AA', # 'magenta',
  6   => '#AA5500', #'brown',
  7   => '#AAAAAA', #'light gray',
  8   => '#555555', #'dark gray'
  9   => '#5555FF', #'light blue'
  10  => '#55FF55', #'light green'
  11  => '#55FFFF', #'light cyan',
  12  => '#FF5555', #'light red',
  13  => '#FF55FF', #'light magenta',
  14  => '#FFFF55', # 'yellow',
  15  => '#FFFFFF', #'white',
}

def mst_load(nazwa_ml, px_ml1 = 0, py_ml1 = 0)

  nazwa_mst = nazwa_ml
  nazwa_mst_c = nazwa_mst+'.mst'

  path = "Tasman/#{nazwa_ml.upcase}.MST"

  f = File.open(path)
  tab = f.read.split(' ')
  mst_ver = "#{tab[0]} #{tab[1]}"
  poziom_l = tab[2].to_i
  pion_l = tab[3].to_i

  out = {name: mst_ver, x: poziom_l, y: pion_l, pixels: [], path: path, name: nazwa_ml}

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
    for i_mst in 1 .. poziom_l * pion_l
      px_ml = px_ml + 1
      ii_ml = ii_ml + 1
      if ii_ml == poziom_l + 1
        ii_ml = 1
        px_ml = px_ml1
        py_ml = py_ml + 1
      end
      if pamie > 1
        pamie = pamie - 1
      end
      if pamie == 1
        mst_kolor_txt = colors[i]

        return out if mst_kolor_txt == nil
        i += 1
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
        end
        if pamie > 0
          pamie = pamie + 1
        end
      end
      out[:pixels] << [px_ml, py_ml, "#{COLORS[mst_kolor.to_i]}"]
      # return if i > 20
    end # for
  end # if
  out
end # mst_load

def draw_image(data, zoom: 1)
  require 'ruby2d'
  set width: data[:x] * zoom, height: data[:y] * zoom
  data[:pixels].each do |pixel|
    x, y, color = pixel
    s = Square.new(x: x * zoom, y: y * zoom, size: zoom)
    s.color = color
  end
  show
end

def to_css(data, zoom: 1, unit: "px")
  f = File.open("out/#{data[:name]}.css", 'w')
  data[:pixels].each do |pixel|
    x, y, color = pixel
    f.write("#{x}#{unit} #{y}#{unit} #{color},\n")
  end
  f.close
end

def to_json(data, zoom: 1)
  f = File.open("out/#{data[:name]}.json", 'w')
  f.write("[\n")
  data[:pixels].each do |pixel|
    x, y, color = pixel
    f.write(" [#{x}, #{y}, \"#{color}\"],\n")
  end
  f.write("]\n")
  f.close
end

# data = mst_load('tas', 0, 0)
# data = mst_load('_buzia', 0, 0)
data = mst_load('_szczeka', 0, 0)
# data = mst_load('_koniec', 0, 0)

puts data[:path]
puts data[:x]
puts data[:y]
puts data[:pixels].size

# draw_image(data)
to_css(data)
to_json(data)
draw_image(data, zoom: 10)
