require "tty-progressbar"

multibar = TTY::ProgressBar::Multi.new

bar = multibar.register("Horse 1 [:bar]", head: ">", total: 100)
xbar = multibar.register("Horse 2 [:bar]", head: ">", total: 100)
30.times do
  sleep(0.05)
  bar.advance(1)
  xbar.advance(2)
end

30.times do
    sleep(0.1)
    bar.advance(-1)
end