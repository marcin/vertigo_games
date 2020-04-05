require 'ruby2d'

colors = {
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
# Set the window size
set width: 1000, height: 1000

# Create a new shape


lines = File.open('tas.colors').read.split("\n")

poziom_l = lines[1].to_i
pion_l = lines[2].to_i


puts "poziom_l: #{poziom_l}"
puts "pion_l: #{pion_l}"
# for i in 3 .. lines.size - 1
#   puts "i: #{i} #{lines[i]}"
# end
# i = 3
# for y in 0 .. yy - 1
#   for  x in 0 .. xx
#     color = lines[i].to_i
#     s = Square.new(x: x, y: y, size: 1)
#     s.color = colors[color]
#     i += 1
#     break if i > 5000
#     puts "i: #{i}"
#   end
# end

px_ml1 = py_ml1 = 0


px_ml = px_ml1-1
py_ml = py_ml1
ii_ml = 0



i = 3

for i_mst in 1 .. poziom_l*pion_l do
  px_ml = px_ml+1
  ii_ml = ii_ml+1
  if ii_ml == poziom_l+1
    ii_ml = 1
    px_ml = px_ml1
    py_ml = py_ml+1
  end
  i += 1
  mst_kolor = lines[i]
  puts "PutPixel(#{px_ml}, #{py_ml}, #{mst_kolor})"
end

# show

# Give it some color


# Show the window
#show


# https://en.wikipedia.org/wiki/Color_Graphics_Adapter

# 0 black #000000
# 1 blue #0000AA
# 2 green #00AA00
# 3 cyan #00AAAA
# 4 red #AA0000
# 5 magenta #AA00AA
# 6 brown #AA5500
# 7 light gray #AAAAAA
# 8 dark gray #555555
# 9 light blue #5555FF
# 10  light green #55FF55
# 11  light cyan #55FFFF
# 12  light red #FF5555
# 13  light magenta #FF55FF
# 14  yellow #FFFF55
# 15  white #FFFFFF