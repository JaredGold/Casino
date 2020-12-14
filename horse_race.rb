require "tty-progressbar"
require "pastel"
require 'tty-prompt'

pastel = Pastel.new
horses = TTY::ProgressBar::Multi.new
prompt = TTY::Prompt.new
bet = 0

def load_money()
  money_val = File.open("money_val.txt")
  money = money_val.read.to_i
  if money <= 9
      money = 100
  end
  money_val.close
  return money
end
update_money_file = proc{
  money_file = File.write('money_val.txt', money.to_s)
}

money = load_money()

gamble_value = proc {
  system('clear')
  puts "Your balance is $#{money}"
  puts "How much would you like to gamble?"
  if bet > money
      bet = money
  end
  if money <= 300
      bet = prompt.slider("Bet", min: 0 , max: money, step: 10, default: bet)
  else
      print 'Ammount: $'
      bet = gets.chomp.to_i
      if bet <= 0
          puts "Invalid amount"
          sleep('0.4')
          gamble_value.call
      end
  end
}

def horse_choices(prompt, pastel)
  choices = [
    {name: "#{pastel.red('King')}", value: 'king'},
    {name: "#{pastel.green('Colt')}", value: 'colt'},
    {name: "#{pastel.blue('Buck')}", value: 'buck'},
    {name: "#{pastel.bright_magenta('Tank')}", value: 'tank'},
    {name: "#{pastel.yellow('Argo')}", value: 'argo'},
    {name: "#{pastel.cyan('Nero')}", value: 'nero'}
]
chosen_option = prompt.select("\nWhich horse would you like to bet on?", choices, help_color: :yellow, help: "(Use Keyboard Arrow Keys)", show_help: :start, filter: true)
end

# Counter Variable
c1 = 0
c2 = 0
c3 = 0
c4 = 0
c5 = 0
c6 = 0

# Horse winner bool
king = false
colt = false
buck = false
tank = false
argo = false
nero = false

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

horse_race = proc{
  horses.on(:done) {puts "Done"}

  horses.on(:stopped) {
    if c1 == 75
      king = true
      reset_counters.call
    elsif c2 == 75
      colt = true
      reset_counters.call
    elsif c3 == 75
      buck = true
      reset_counters.call
    elsif c4 == 75
      tank = true
      reset_counters.call
    elsif c5 == 75
      argo = true
      reset_counters.call
    elsif c6 == 75
      nero = true
      reset_counters.call
    end
  }

  bar1 = horses.register("#{pastel.red('King')} [:bar]", head: "#{pastel.red('>')}", total: 75)
  bar2 = horses.register("#{pastel.green('Colt')} [:bar]", head: "#{pastel.green('>')}", total: 75)
  bar3 = horses.register("#{pastel.blue('Buck')} [:bar]", head: "#{pastel.blue('>')}", total: 75)
  bar4 = horses.register("#{pastel.bright_magenta('Tank')} [:bar]", head: "#{pastel.bright_magenta('>')}", total: 75)
  bar5 = horses.register("#{pastel.yellow('Argo')} [:bar]", head: "#{pastel.yellow('>')}", total: 75)#
  bar6 = horses.register("#{pastel.cyan('Nero')} [:bar]", head: "#{pastel.cyan('>')}", total: 75)

  th1 = Thread.new { 75.times {wait() ; bar1.advance ; c1 += 1 ; horses.stop if c1 == 75} } 
  th2 = Thread.new { 75.times {wait() ; bar2.advance ; c2 += 1 ; horses.stop if c2 == 75} }
  th3 = Thread.new { 75.times {wait() ; bar3.advance ; c3 += 1 ; horses.stop if c3 == 75} }
  th4 = Thread.new { 75.times {wait() ; bar4.advance ; c4 += 1 ; horses.stop if c4 == 75} }
  th5 = Thread.new { 75.times {wait() ; bar5.advance ; c5 += 1 ; horses.stop if c5 == 75} }
  th6 = Thread.new { 75.times {wait() ; bar6.advance ; c6 += 1 ; horses.stop if c6 == 75} }


  [th1, th2, th3, th4, th5, th6].each { |t| t.join }

  if king
    puts "\n#{pastel.red('King')} won"
  elsif colt
    puts "\n#{pastel.green('Colt')} won"
  elsif buck
    puts "\n#{pastel.blue('Buck')} won"
  elsif tank
    puts "\n#{pastel.bright_magenta('Tank')} won"
  elsif argo
    puts "\n#{pastel.yellow('Argo')} won"
  elsif nero
    puts "\n#{pastel.cyan('Nero')} won"
  end
}

gamble_value.call
player_horse = horse_choices(prompt, pastel)
horse_race.call


