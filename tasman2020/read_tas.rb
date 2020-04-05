
file_name = "tas"

f = File.open("../Tasman/#{file_name.upcase}.MST")


tab = f.read.split(' ')

x = tab[2]
y = tab[3]


puts "x: #{x} y: #{y}"

colors2 = {a: 10, b: 11, c: 12, d: 13, e: 14, f: 15}

digits = {p: 1, r: 2, s: 3, t: 4, u: 5, w: 6, x: 7, y: 8}

File.open("#{file_name}.colors", 'w') do |file|
  file.write("# 2 linia x, 3 linia y, reszta to kolejne kolory\n")
  file.write("#{x}\n")
  file.write("#{y}\n")
  chars = tab[4].split('')
  i = 0
  while i < chars.size

    ch = chars[i]
    puts ch

    if colors2.keys.include?(ch.to_sym)
      ch = colors2[ch.to_sym]
      file.write("#{ch}\n")
    elsif ch == '0' || ( ch.to_i >= 1 && ch.to_i <= 9)
      # ok
      file.write("#{ch}\n")
    elsif digits.keys.include?(ch.to_sym)
      d = digits[ch.to_sym]
      prev_ch = chars[i - 1]

      number = ''
      i += 1
      for j in 0 .. d - 1
        number += chars[i]
        i += 1
      end
      puts "number: #{number}"
      # return
      for j in 1 .. number.to_i
        file.write("#{prev_ch}\n")
      end
    else
      puts "zle ch: #{ch}"
      raise
    end

    i+= 1
  end
end


