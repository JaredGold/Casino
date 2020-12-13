require "tty-progressbar"
require "pastel"

pastel = Pastel.new
green  = pastel.on_green(" ")
red    = pastel.on_red(" ")
blue    = pastel.on_blue(" ")
horses = TTY::ProgressBar::Multi.new

# Counter Variable
c1 = 0
c2 = 0
c3 = 0
c4 = 0
c5 = 0
c6 = 0

# Horse winner bool
a1 = false
a2 = false
a3 = false
a4 = false
a5 = false
a6 = false

def wait()
  time = rand(0.01..0.15)
  sleep(time)
end

reset_counters = proc{
  c1 = 0
  c2 = 0
  c3 = 0
  c4 = 0
  c5 = 0
  c6 = 0
}

horses.on(:done) {puts "Done"}

horses.on(:stopped) {
  if c1 == 75
    a1 = true
    reset_counters.call
  elsif c2 == 75
    a2 = true
    reset_counters.call
  elsif c3 == 75
    a3 = true
    reset_counters.call
  elsif c4 == 75
    a4 = true
    reset_counters.call
  elsif c5 == 75
    a5 = true
    reset_counters.call
  elsif c6 == 75
    a6 = true
    reset_counters.call
  end
}

bar1 = horses.register("King [:bar]", head: ">", total: 75)#, complete: green, incomplete: red)
bar2 = horses.register("Colt [:bar]", head: ">", total: 75)#, complete: green, incomplete: red)
bar3 = horses.register("Buck [:bar]", head: ">", total: 75)#, complete: green, incomplete: red)
bar4 = horses.register("Tank [:bar]", head: ">", total: 75)#, complete: green, incomplete: red)
bar5 = horses.register("Argo [:bar]", head: ">", total: 75)#, complete: green, incomplete: red)
bar6 = horses.register("Nero [:bar]", head: ">", total: 75)#, complete: green, incomplete: red)

th1 = Thread.new { 75.times {wait() ; bar1.advance ; c1 += 1 ; horses.stop if c1 == 75} } 
th2 = Thread.new { 75.times {wait() ; bar2.advance ; c2 += 1 ; horses.stop if c2 == 75} }
th3 = Thread.new { 75.times {wait() ; bar3.advance ; c3 += 1 ; horses.stop if c3 == 75} }
th4 = Thread.new { 75.times {wait() ; bar4.advance ; c4 += 1 ; horses.stop if c4 == 75} }
th5 = Thread.new { 75.times {wait() ; bar5.advance ; c5 += 1 ; horses.stop if c5 == 75} }
th6 = Thread.new { 75.times {wait() ; bar6.advance ; c6 += 1 ; horses.stop if c6 == 75} }


[th1, th2, th3, th4, th5, th6].each { |t| t.join }


if a1
  puts 'King won'
elsif a2
  puts 'Colt won'
elsif a3
  puts 'Buck won'
elsif a4
  puts 'Tank won'
elsif a5
  puts 'Argo won'
elsif a6
  puts 'Nero won'
end