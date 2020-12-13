require "tty-progressbar"

multibar = TTY::ProgressBar::Multi.new

def wait()
  time = rand(0.01..0.15)
  sleep(time)
end

multibar.on(:done) {puts "Done"}

bar1 = multibar.register("1 [:bar]", head: ">", total: 100)
bar2 = multibar.register("2 [:bar]", head: ">", total: 100)
bar3 = multibar.register("3 [:bar]", head: ">", total: 100)
bar4 = multibar.register("4 [:bar]", head: ">", total: 100)
bar5 = multibar.register("5 [:bar]", head: ">", total: 100)
bar6 = multibar.register("6 [:bar]", head: ">", total: 100)

th1 = Thread.new { 100.times {wait() ; bar1.advance } }
th2 = Thread.new { 100.times {wait() ; bar2.advance } }
th3 = Thread.new { 100.times {wait() ; bar3.advance } }
th4 = Thread.new { 100.times {wait() ; bar4.advance } }
th5 = Thread.new { 100.times {wait() ; bar5.advance } }
th6 = Thread.new { 100.times {wait() ; bar6.advance } }

# if 
#   puts "I MADE IT HERE!"
# end




[th1, th2, th3, th4, th5, th6].each { |t| t.join }

