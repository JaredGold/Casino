require "tty-progressbar"
require "pastel"

pastel = Pastel.new
green  = pastel.on_green(" ")
red    = pastel.on_red(" ")
blue    = pastel.on_blue(" ")
horses = TTY::ProgressBar::Multi.new

def wait()
  time = rand(0.01..0.15)
  sleep(time)
end

c1 = 0
c2 = 0
c3 = 0
c4 = 0
c5 = 0
c6 = 0

horses.on(:done) {puts "Done"}

bar1 = horses.register("1 [:bar]", head: ">", total: 75)#, complete: green, incomplete: red)
bar2 = horses.register("2 [:bar]", head: ">", total: 75)#, complete: green, incomplete: red)
bar3 = horses.register("3 [:bar]", head: ">", total: 75)#, complete: green, incomplete: red)
bar4 = horses.register("4 [:bar]", head: ">", total: 75)#, complete: green, incomplete: red)
bar5 = horses.register("5 [:bar]", head: ">", total: 75)#, complete: green, incomplete: red)
bar6 = horses.register("6 [:bar]", head: ">", total: 75)#, complete: green, incomplete: red)

th1 = Thread.new { 75.times {wait() ; bar1.advance ; c1 += 1 ; horses.stop if c1 == 75} ; horses.stop if c2 == 75 ; horses.stop if c3 == 75 ; horses.stop if c4 == 75 ; horses.stop if c5 == 75 ; horses.stop if c6 == 75} 
th2 = Thread.new { 75.times {wait() ; bar2.advance ; c2 += 1 ; horses.stop if c2 == 75} }
th3 = Thread.new { 75.times {wait() ; bar3.advance ; c3 += 1 ; horses.stop if c3 == 75} }
th4 = Thread.new { 75.times {wait() ; bar4.advance ; c4 += 1 ; horses.stop if c4 == 75} }
th5 = Thread.new { 75.times {wait() ; bar5.advance ; c5 += 1 ; horses.stop if c5 == 75} }
th6 = Thread.new { 75.times {wait() ; bar6.advance ; c6 += 1 ; horses.stop if c6 == 75} }


[th1, th2, th3, th4, th5, th6].each { |t| t.join }

if c1 == 75
  puts "Horse 1 Won!"
elsif c2 == 75
  puts "Horse 2 Won!"
elsif c3 == 75
  puts "Horse 3 Won!"
elsif c4 == 75
  puts "Horse 4 Won!"
elsif c5 == 75
  puts "Horse 5 Won!"
elsif c6 == 75
  puts "Horse 6 Won!"
else
  puts "error?"
end
