# Initialization
require 'tty-box'
require 'tty-table'
require 'tty-prompt'
require 'ascii_charts'
require 'timeout'
require 'pastel'
require './cards.rb'
require './deck.rb'

# Variables
deck = []
pastel = Pastel.new
player_hand = []
banker_hand = []
player_value = 0
banker_value = 0
bet = 0
game_loop = true
prompt = TTY::Prompt.new
blank_card = @card = TTY::Box.frame(width: 5, height: 4, align: :center, border: :thick,title: {top_left: " ? ", bottom_right: " ? "}) do "" end
crash_x = 0.2
crash_y = ''
crash_start_array = [[crash_y, crash_x]]
crash_array = crash_start_array
lose = false


# Creates a brand new deck
def create_deck
    all_cards = []
    # Hearts ♥
    all_cards << ace_of_hearts = Ace.new('A', 'hearts', "♥")
    all_cards << king_of_hearts = Card.new('K', 'hearts', 10, "♥")
    all_cards << queen_of_hearts = Card.new('Q', 'hearts', 10, "♥")
    all_cards << jack_of_hearts = Card.new('J', 'hearts', 10, "♥")
    all_cards << ten_of_hearts = Card.new('10', 'hearts', 10, "♥")
    all_cards << nine_of_hearts = Card.new('9', 'hearts', 9, "♥")
    all_cards << eight_of_hearts = Card.new('8', 'hearts', 8, "♥")
    all_cards << seven_of_hearts = Card.new('7', 'hearts', 7, "♥")
    all_cards << six_of_hearts = Card.new('6', 'hearts', 6, "♥")
    all_cards << five_of_hearts = Card.new('5', 'hearts', 5, "♥")
    all_cards << four_of_hearts = Card.new('4', 'hearts', 4, "♥")
    all_cards << three_of_hearts = Card.new('3', 'hearts', 3, "♥")
    all_cards << two_of_hearts = Card.new('2', 'hearts', 2, "♥")
    # Spades ♠
    all_cards << ace_of_spades = Ace.new('A', 'spades', "♠")
    all_cards << king_of_spades = Card.new('K', 'spades', 10, "♠")
    all_cards << queen_of_spades = Card.new('Q', 'spades', 10, "♠")
    all_cards << jack_of_spades = Card.new('J', 'spades', 10, "♠")
    all_cards << ten_of_spades = Card.new('10', 'spades', 10, "♠")
    all_cards << nine_of_spades = Card.new('9', 'spades', 9, "♠")
    all_cards << eight_of_spades = Card.new('8', 'spades', 8, "♠")
    all_cards << seven_of_spades = Card.new('7', 'spades', 7, "♠")
    all_cards << six_of_spades = Card.new('6', 'spades', 6, "♠")
    all_cards << five_of_spades = Card.new('5', 'spades', 5, "♠")
    all_cards << four_of_spades = Card.new('4', 'spades', 4, "♠")
    all_cards << three_of_spades = Card.new('3', 'spades', 3, "♠")
    all_cards << two_of_spades = Card.new('2', 'spades', 2, "♠")
    # Diamonds ♦
    all_cards << ace_of_diamonds = Ace.new('A', 'diamonds', "♦")
    all_cards << king_of_diamonds = Card.new('K', 'diamonds', 10, "♦")
    all_cards << queen_of_diamonds = Card.new('Q', 'diamonds', 10, "♦")
    all_cards << jack_of_diamonds = Card.new('J', 'diamonds', 10, "♦")
    all_cards << ten_of_diamonds = Card.new('10', 'diamonds', 10, "♦")
    all_cards << nine_of_diamonds = Card.new('9', 'diamonds', 9, "♦")
    all_cards << eight_of_diamonds = Card.new('8', 'diamonds', 8, "♦")
    all_cards << seven_of_diamonds = Card.new('7', 'diamonds', 7, "♦")
    all_cards << six_of_diamonds = Card.new('6', 'diamonds', 6, "♦")
    all_cards << five_of_diamonds = Card.new('5', 'diamonds', 5, "♦")
    all_cards << four_of_diamonds = Card.new('4', 'diamonds', 4, "♦")
    all_cards << three_of_diamonds = Card.new('3', 'diamonds', 3, "♦")
    all_cards << two_of_diamonds = Card.new('2', 'diamonds', 2, "♦")
    # Clubs ♣
    all_cards << ace_of_clubs = Ace.new('A', 'clubs', "♣")
    all_cards << king_of_clubs = Card.new('K', 'clubs', 10, "♣")
    all_cards << queen_of_clubs = Card.new('Q', 'clubs', 10, "♣")
    all_cards << jack_of_clubs = Card.new('J', 'clubs', 10, "♣")
    all_cards << ten_of_clubs = Card.new('10', 'clubs', 10, "♣")
    all_cards << nine_of_clubs = Card.new('9', 'clubs', 9, "♣")
    all_cards << eight_of_clubs = Card.new('8', 'clubs', 8, "♣")
    all_cards << seven_of_clubs = Card.new('7', 'clubs', 7, "♣")
    all_cards << six_of_clubs = Card.new('6', 'clubs', 6, "♣")
    all_cards << five_of_clubs = Card.new('5', 'clubs', 5, "♣")
    all_cards << four_of_clubs = Card.new('4', 'clubs', 4, "♣")
    all_cards << three_of_clubs = Card.new('3', 'clubs', 3, "♣")
    all_cards << two_of_clubs = Card.new('2', 'clubs', 2, "♣")
    all_cards
end
# Loads money file
def load_money()
    begin
    money_val = File.open("money_val.txt")
    rescue 
        puts "No File found - Creating new File"
        money_val = File.new("money_val.txt", "a+")
    end

    money = money_val.read.to_i
    if money <= 9 || money == nil
        money = 100
    end
    money_val.close
    return money
end

# Load money on start
money = load_money()

# Writes to money file
update_money_file = proc{
    money_file = File.write('money_val.txt', money.to_i.to_s)
}

# Reset Current Deck
reset_deck = proc{
    deck = Deck.new(create_deck)
}

# reset's hands for blackjack
reset_hands = proc{
    player_hand = []
    banker_hand = []
    player_value = 0
    banker_value = 0
    game_loop = true
}

# reset crash variables
reset_crash = proc {
    crash_x = 0.2
    crash_y = ''
    crash_start_array = [[crash_y, crash_x]]
    crash_array = crash_start_array

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

# deal hands for blackjack
deal_blackjack = proc {
    deck.shuffle
    player_hand << deck.draw_card
    banker_hand << deck.draw_card
    player_hand << deck.draw_card
    banker_hand << deck.draw_card
}

# update hand value for blackjack
update_hand_values = proc{
    player_value = player_hand.reduce(0) do |sum , card|
        sum += card.value
    end
    banker_value = banker_hand.reduce(0) do |sum , card|
        sum += card.value
    end
}

# renders out the hands for blackjack
def render_hand(banker_value, banker_renderer, player_value, player_renderer)

    system('clear')
    puts "Dealer's Cards"
    puts banker_value
    puts banker_renderer.render

    puts "---------------------------"

    puts "Your Cards"
    puts player_value
    puts player_renderer.render
end

# Draws the hands visually for blackjack
draw_visible_hand = proc {
    player_table = TTY::Table.new([[player_hand[0], player_hand[1], player_hand[2], player_hand[3], player_hand[4]]])
    player_multi_renderer = TTY::Table::Renderer::Basic.new(player_table, multiline: true)
    banker_table = TTY::Table.new([[banker_hand[0], banker_hand[1], banker_hand[2], banker_hand[3], banker_hand[4]]])
    banker_multi_renderer = TTY::Table::Renderer::Basic.new(banker_table, multiline: true)
    
    update_hand_values.call
    # render/draw table
    render_hand(banker_value, banker_multi_renderer, player_value, player_multi_renderer)
}

# Draws out hidden hand for blackjack
draw_hidden_hand = proc {
    player_table = TTY::Table.new([[player_hand[0], player_hand[1], player_hand[2], player_hand[3], player_hand[4]]])
    player_multi_renderer = TTY::Table::Renderer::Basic.new(player_table, multiline: true)
    banker_table = TTY::Table.new([[blank_card, banker_hand[1], banker_hand[2], banker_hand[3], banker_hand[4]]])
    banker_multi_renderer = TTY::Table::Renderer::Basic.new(banker_table, multiline: true)
    
    update_hand_values.call
    # render/draw table
    render_hand((banker_value - banker_hand[0].value), banker_multi_renderer, player_value, player_multi_renderer)
}

# Creates Options - Hit, Stand, Exit
def play_options(prompt)
    choices = [
        {name: "Hit", value: 1},
        {name: "Stand", value: 2},
        {name: "Exit", value: 3}
    ]
    chosen_option = prompt.select("What would you like to do?", choices, help_color: :yellow, help: "(Use Keyboard Arrow Keys)", show_help: :start, filter: true)
end

# asks gamble value
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
        print 'Amount: $'
        bet = gets.chomp.to_i
        if bet <= 0 || bet > money
            puts "Invalid amount"
            sleep(0.4)
            gamble_value.call
        end
    end
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



blackjack = proc {
    
    gamble_value.call
    reset_hands.call
    reset_deck.call
    deal_blackjack.call
    draw_hidden_hand.call


    # Gameplay Loop
    while game_loop
        # Gives Options (Hit, Stand, Exit)
        user_choice = play_options(prompt)

        case user_choice
        when 1
            # Gives Player a card
            player_hand << deck.draw_card
            draw_hidden_hand.call
            
            # Check for if loss state can be avoided
            if player_value > 21
                player_hand.each_with_index do |card , index|
                    if card.kind_of?(Ace) && card.value == 11    
                        card.value_change
                        draw_hidden_hand.call
                    end
                end
                if player_value > 21
                    draw_visible_hand.call
                    game_loop = false
                end
            end

            user_choice = 0
        when 2
            while true
                if banker_value < 17
                    # Show player the hidden card and new banker value
                    draw_visible_hand.call

                    # Draw a new card for the banker and update the table and values
                    banker_hand << deck.draw_card
                    update_hand_values.call

                    # Pause for effect!
                    sleep(0.75)
                else
                    banker_hand.each_with_index do |card , index|
                        if card.kind_of?(Ace) && card.value == 11    
                            card.value_change
                            draw_visible_hand.call
                            break
                        end
                    end
                    
                    if banker_value >= 17
                        break
                    end  
                end
            end

            draw_visible_hand.call
            chosen_option = 0
            game_loop = false
        when 3
            lose = true
            user_choice = 0
            break
        end
    end



    # Win Logic
    sleep(1)
    system('clear')
    if banker_value > 21
        puts "Congratulations you won $#{bet}!"
        money += bet
    elsif banker_value > player_value || player_value > 21 || lose == true
        puts "You lost $#{bet}..."
        money -= bet
        update_money_file.call
        lose = false
        if money <= 0
            sleep (1)
            money_check.call
        end
    elsif player_value == banker_value
        puts "Draw"
    else
        puts "Congratulations you won $#{bet}!"
        money += bet
        update_money_file.call
    end 


    choices = [
        {name: "Yes", value: 1},
        {name: "No", value: 2},
    ]
    chosen_option = prompt.select("Would you like to replay Blackjack?", choices, help_color: :yellow, help: "(Use Keyboard Arrow Keys)", show_help: :start, filter: true)

    if chosen_option == 1
        blackjack.call
    elsif chosen_option == 2
        exit_options.call
    end

}

blackjack_menu = proc{
    system('clear')
    blackjack_title()
    chosen_option = game_menu_options(prompt)
    if chosen_option == 1
        blackjack.call
    elsif chosen_option == 2
        blackjack_rules(blackjack_menu)
    else
        exit_options.call
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

def blackjack_rules(menu)
    system('clear')
    puts "Goal: "
    puts "The goal of blackjack is to beat the dealer's hand without going over 21"
    puts "Picture Cards are worth 10 and Aces are worth 11 or 1."
    puts "\nHow to Play: "
    puts "At the start of the game you are shown 2 cards of yours and 1 of the dealer's"
    puts "You have the choice to get another card (hit) or stand"
    puts "If you choose to hit and go over 21 you immediately lose."
    puts "Otherwise you can continue hitting."
    puts "When you finally stand, the dealer then draws until they are between 17-21."
    puts "The winner is the player who is closer to 21"
    puts "\n----------------------------------------------------------------------------"
    puts "\nPress return to go back"
    x = gets.chomp
    menu.call
end

casino_title = proc{
    puts " 
    ▄████████    ▄████████    ▄████████  ▄█  ███▄▄▄▄    ▄██████▄  
    ███    ███   ███    ███   ███    ███ ███  ███▀▀▀██▄ ███    ███ 
    ███    █▀    ███    ███   ███    █▀  ███▌ ███   ███ ███    ███ 
    ███          ███    ███   ███        ███▌ ███   ███ ███    ███ 
    ███        ▀███████████ ▀███████████ ███▌ ███   ███ ███    ███ 
    ███    █▄    ███    ███          ███ ███  ███   ███ ███    ███ 
    ███    ███   ███    ███    ▄█    ███ ███  ███   ███ ███    ███ 
    ████████▀    ███    █▀   ▄████████▀  █▀    ▀█   █▀   ▀██████▀  
                                                                   "
}

def blackjack_title()
    puts "
    ██████╗ ██╗      █████╗  ██████╗██╗  ██╗     ██╗ █████╗  ██████╗██╗  ██╗
    ██╔══██╗██║     ██╔══██╗██╔════╝██║ ██╔╝     ██║██╔══██╗██╔════╝██║ ██╔╝
    ██████╔╝██║     ███████║██║     █████╔╝      ██║███████║██║     █████╔╝ 
    ██╔══██╗██║     ██╔══██║██║     ██╔═██╗ ██   ██║██╔══██║██║     ██╔═██╗ 
    ██████╔╝███████╗██║  ██║╚██████╗██║  ██╗╚█████╔╝██║  ██║╚██████╗██║  ██╗
    ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝ ╚════╝ ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝"
end



# Start Menu
def start_menu(prompt, casino, money, pastel)
    system('clear')
    casino.call
    puts "Welcome one welcome all to the wonderful world of gambling!"
    puts "Your current balance is #{pastel.yellow("$") + pastel.yellow(money)}"
    
    choices = [
        {name: "Games", value: 'games'},
        {name: "Help", value: 'help'},
        {name: "Exit", value: 'exit'}
    ]
    chosen_option = prompt.select("What would you like?", choices, help_color: :yellow, help: "(Use Keyboard Arrow keys)", show_help: :start, filter: true)
    
    if chosen_option == 'games'
        system('clear')
        casino.call
        choices = [
            {name: "Blackjack", value: 'bj'},
            {name: "Crash", value: 'cr'},
            {name: "Horse Racing", value: 'hr'},
            {name: "Back", value: 3}
        ]
        chosen_option = prompt.select("Which game would you like to play?", choices, help_color: :yellow, help: "(Use Keyboard Arrow keys)", show_help: :start, filter: true)
        if chosen_option == 3
            start_menu(prompt, casino, money, pastel)
        else
            return chosen_option
        end   
    elsif chosen_option == 'help'
        main_help()
    elsif chosen_option == 'exit'
        system('clear')
        exit
    end
end


def main_help()
    system('clear')
    puts "Welcome to Casino!"
    puts "\nIn Casino the main goal is to make as much money as possible and have fun!"
    puts "There are currently 3 games you can play, Blackjack, Crash and Horse Racing."
    puts "Each game has it's own Rules so if you want to read more do so in those games."
    puts "\nRemember this is just a game. If you do find gambling addictive, please seek"
    puts "professional help and read more at https://www.gamblinghelponline.org.au/"
    if ARGV.count > 0
        exit(0)
    end
    puts "\n-------------------------------------------------------------------------"
    puts "\nPress return to go back"
    wait = gets.chomp
    system('ruby play.rb')
end


crash = proc{
    reset_crash.call
    gamble_value.call
    crash_loop = true
    while crash_loop

    odds = [(1..50).to_a.sample, (1..40).to_a.sample, (1..30).to_a.sample, (1..20).to_a.sample]

    if crash_x < 1
        chance = odds[0]
    elsif crash_x < 3
        chance = odds[1]
    elsif crash_x < 10
        chance = odds[2]
    else
        chance = odds[3]
    end

    puts chance

    if chance != 1

        system('clear')
        puts AsciiCharts::Cartesian.new(crash_array, :title => "YOUR MONEY").draw
        puts crash_x

        begin
            status = Timeout::timeout(0.4){
                gets.chomp
                crash_loop = false
            }
        rescue Timeout::Error
        end

        crash_x *= 1.1
        crash_x = crash_x.round(2)
        crash_array << [crash_y, crash_x]

        crash_array.shift if crash_array.length == 11
        else
            puts "YOU LOSE"
            crash_x = 0
            crash_loop = false
        end
    end

    if crash_x == 0
        puts "You lost $#{bet}"
        money = money - bet
        update_money_file.call
    elsif crash_x < 1
        puts "You only received $#{(crash_x * bet).round(0)}..."
        money = (money - bet) + (crash_x * bet)
        update_money_file.call
    else
        puts "You won $#{(crash_x * bet).round(0)}!"
        money = (money - bet) + (crash_x * bet)
        update_money_file.call
    end

    money_check.call

    choices = [
        {name: "Yes", value: 1},
        {name: "No", value: 2},
    ]
    chosen_option = prompt.select("Would you like to play Crash again?", choices, help_color: :yellow, help: "(Use Keyboard Arrow Keys)", show_help: :start, filter: true)

    if chosen_option == 1
        crash.call
    elsif chosen_option == 2
        exit_options.call
    end

}

def crash_title()
    puts " 
    ▄████▄   ██▀███   ▄▄▄        ██████  ██░ ██ 
    ▒██▀ ▀█  ▓██ ▒ ██▒▒████▄    ▒██    ▒ ▓██░ ██▒
    ▒▓█    ▄ ▓██ ░▄█ ▒▒██  ▀█▄  ░ ▓██▄   ▒██▀▀██░
    ▒▓▓▄ ▄██▒▒██▀▀█▄  ░██▄▄▄▄██   ▒   ██▒░▓█ ░██ 
    ▒ ▓███▀ ░░██▓ ▒██▒ ▓█   ▓██▒▒██████▒▒░▓█▒░██▓
    ░ ░▒ ▒  ░░ ▒▓ ░▒▓░ ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒
      ░  ▒     ░▒ ░ ▒░  ▒   ▒▒ ░░ ░▒  ░ ░ ▒ ░▒░ ░
    ░          ░░   ░   ░   ▒   ░  ░  ░   ░  ░░ ░
    ░ ░         ░           ░  ░      ░   ░  ░  ░
    ░                                            "
end

crash_menu = proc{
    system('clear')
    crash_title()
    chosen_option = game_menu_options(prompt)
    if chosen_option == 1
        crash.call
    elsif chosen_option == 2
        crash_rules(crash_menu)
    else
        exit_options.call
    end

}

def crash_rules(menu)
    system('clear')
    puts "Goal: "
    puts "The goal of Crash is to get out before it's too late!"
    puts "Slowly the stocks will grow but at any point they can crash."
    puts "If you have not backed out before then you lose your entire bet."
    puts "\nHow to Play: "
    puts "After choosing a bet amount you will watch the market grow."
    puts "At any point you can press return to accept the market value."
    puts "You receive the market value times your bet."
    puts "\n----------------------------------------------------------------------------"
    puts "\nPress return to go back"
    x = gets.chomp
    menu.call
end


#Main game loop
if ARGV.count > 0
    if ARGV[0] == '-bj'     || ARGV[0] == '--blackjack'
        ARGV.clear
        blackjack_menu.call
    elsif ARGV[0] == '-cr'  || ARGV[0] == '--crash'
        ARGV.clear
        crash_menu.call
    elsif ARGV[0] == '-hr'  || ARGV[0] == '--horserace'
        ARGV.clear
        system('ruby horse_race.rb')
    elsif ARGV[0] == '-h'   || ARGV[0] == '--help'
        main_help()
        ARGV.clear
        exit
    else
        puts "Incorrect Command"
        puts "  For help type '-h' or '--help'"
        puts "  For Blackjack type '-bj' or '--blackjack'"
        puts "  For Crash type '-cr' or '--crash'"
        puts "  For Horse Racing type '-hr' or '--horseracing'"
    end
else
    game_option = start_menu(prompt, casino_title, money, pastel)
    if game_option == 'bj'
        blackjack_menu.call
    elsif game_option == 'cr'
        crash_menu.call
    elsif game_option == 'hr'
        system('ruby horse_race.rb')
    end
end