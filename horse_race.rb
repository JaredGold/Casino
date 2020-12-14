require "tty-progressbar"
require "pastel"
require 'tty-prompt'

pastel = Pastel.new
horses = TTY::ProgressBar::Multi.new
prompt = TTY::Prompt.new
bet = 0
player_horse = ''

def load_money()
  money_val = File.open("money_val.txt")
  money = money_val.read.to_i
  if money <= 9
      money = 100
  end
  money_val.close
  return money
end

money = load_money()

update_money_file = proc{
  money_file = File.write('money_val.txt', money.to_s)
}

money_check = proc{
  if money <= 10
      system('clear')
      puts "You dropped below $10 you had $#{money}"
      puts "YOU LOSE!"
      sleep(2)
      puts "Money reset to $10"
      money = 10
      update_money_file.call
  end
}

exit_options = proc{
  choices = [
      {name: "Return to Menu", value: 'menu'},
      {name: "Quit", value: 'quit'},
  ]
  chosen_option = prompt.select("What would you like to do?", choices, help_color: :yellow, help: "(Use Keyboard Arrow Keys)", show_help: :start, filter: true)
  if chosen_option == 'menu'
      # IF YOU HAVE TO CHANGE THIS LATER DO SO!
      system('ruby play.rb')
      exit
  elsif chosen_option == 'quit'
      system('clear')
      exit
  end
}

def game_menu_options(prompt)
  choices = [
      {name: "Play", value: 1},
      {name: "Rules", value: 2},
      {name: "Exit", value: 3}
  ]
  chosen_option = prompt.select("", choices, help_color: :dim, help: "(Use Keyboard Arrow Keys)", show_help: :start, filter: true)
end

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
  return chosen_option
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

def races_title()
  puts"
  _  _ ____ ____ ____ ____    ____ ____ ____ ____ 
  |__| |  | |__/ [__  |___    |__/ |__| |    |___ 
  |  | |__| |  \\ ___] |___    |  \\ |  | |___ |___ 
  "
end

reset_counters = proc{
  c1 = 0
  c2 = 0
  c3 = 0
  c4 = 0
  c5 = 0
  c6 = 0
}

reset_horses = proc{ 
  king = false
  colt = false
  buck = false
  tank = false
  argo = false
  nero = false
}

horse_race = proc{
  system('clear')
  reset_counters.call
  reset_horses.call
  gamble_value.call
  player_horse = horse_choices(prompt, pastel)

  # horses.on(:done) {puts "Done"}

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

  

  [th1, th2, th3, th4, th5, th6].each { |t| t.join ; t.exit}


  win_procedure = proc{
    puts "Congratulations! You won $#{bet * 6}"
    money = money + (bet * 6)
    update_money_file.call
  }

  if king && player_horse == 'king'
    win_procedure.call
  elsif colt && player_horse == 'colt'
    win_procedure.call
  elsif buck && player_horse == 'buck'
    win_procedure.call
  elsif tank && player_horse == 'tank'
    win_procedure.call
  elsif argo && player_horse == 'argo'
    win_procedure.call
  elsif nero && player_horse == 'nero'
    win_procedure.call
  else
    puts "You lost $#{bet}"
    money = money - bet
    update_money_file.call
  end

  money_check.call

  choices = [
    {name: "Yes", value: 1},
    {name: "No", value: 2},
  ]
  chosen_option = prompt.select("Would you like to replay Horse Races?", choices, help_color: :yellow, help: "(Use Keyboard Arrow Keys)", show_help: :start, filter: true)

  if chosen_option == 1
      horse_race.call
  elsif chosen_option == 2
      exit_options.call
  end
}

def hr_rules(menu)
  system('clear')
  puts "Goal: "
  puts "Pick a winning horse!"
  puts "\nHow to Play: "
  puts "Choose a horse at the start and watch the races"
  puts "If your horse wins you win your bet times 6"
  puts "\n----------------------------------------------------------------------------"
  puts "\nPress return to go back"
  x = gets.chomp
  menu.call
end

hr_menu = proc{
  system('clear')
  races_title()
  chosen_option = game_menu_options(prompt)
  if chosen_option == 1
    horse_race.call
  elsif chosen_option == 2
    hr_rules(hr_menu)
  else
    exit_options.call
  end
}

hr_menu.call