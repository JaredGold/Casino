# Initialisation
require 'tty-box'
require 'tty-table'
require 'tty-prompt'
require './cards.rb'
require './deck.rb'

# Variables
deck = []
player_hand = []
banker_hand = []
player_value = 0
banker_value = 0
bet = 0
game_loop = true
prompt = TTY::Prompt.new
blank_card = @card = TTY::Box.frame(width: 5, height: 4, align: :center, border: :thick,title: {top_left: " ? ", bottom_right: " ? "}) do "" end


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
    money_val = File.open("money_val.txt")
    money = money_val.read.to_i
    if money == 0
        money = 100
    end
    money_val.close
    return money
end

# Load money on start
money = load_money()

# Writes to money file
update_money_file = proc{
    money_file = File.write('money_val.txt', money.to_s)
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
def render_hand(banker_value, banker_renderer, player_value, player_renderer, update)
    # Finds hand values
    update.call

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
    
    # render/draw table
    render_hand(banker_value, banker_multi_renderer, player_value, player_multi_renderer, update_hand_values)
}

# Draws out hidden hand for blackjack
draw_hidden_hand = proc {
    player_table = TTY::Table.new([[player_hand[0], player_hand[1], player_hand[2], player_hand[3], player_hand[4]]])
    player_multi_renderer = TTY::Table::Renderer::Basic.new(player_table, multiline: true)
    banker_table = TTY::Table.new([[blank_card, banker_hand[1], banker_hand[2], banker_hand[3], banker_hand[4]]])
    banker_multi_renderer = TTY::Table::Renderer::Basic.new(banker_table, multiline: true)
    
    # render/draw table
    render_hand(banker_value, banker_multi_renderer, player_value, player_multi_renderer, update_hand_values)
}

# Creates Options - Hit, Stand, Exit
def play_options(prompt)
    choices = [
        {name: "Hit", value: 1},
        {name: "Stand", value: 2},
        {name: "Exit", value: 3}
    ]
    chosen_option = prompt.select("What would you like to do?", choices, help_color: :yellow, help: "(Use Keybvoard keys)", show_help: :start, filter: true)
end

# asks gamble value
gamble_value = proc {
    system('clear')
    puts "Your balance is $#{money}"
    puts "How much would you like to gamble?"
    if bet > money
        bet = money
    end
    bet = prompt.slider("Bet", min: 0 , max: money, step: 10, default: bet)
}


