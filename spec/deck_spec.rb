require '../cards.rb'
require '../play.rb'

ace_of_hearts = Ace.new('A', 'hearts', "♥")
king_of_hearts = Card.new('K', 'hearts', 10, "♥")
nine_of_hearts = Card.new('9', 'hearts', 9, "♥")
four_of_hearts = Card.new('4', 'hearts', 4, "♥")
two_of_hearts = Card.new('2', 'hearts', 2, "♥")
ten_of_spades = Card.new('10', 'spades', 10, "♠")
eight_of_diamonds = Card.new('8', 'diamonds', 8, "♦")
five_of_clubs = Card.new('5', 'clubs', 5, "♣")

describe 'check card value' do
    it 'has correct card values' do
      expect(king_of_hearts.value).to eq(10)
      expect(four_of_hearts.value).to eq(4)
      expect(two_of_hearts.value).to eq(2)
      expect(ace_of_hearts.value).to eq(11)
      expect(nine_of_hearts.value).to eq(9)
      expect(eight_of_diamonds.value).to eq(8)
    end
end

describe 'check card suit' do
    it 'has correct suit' do
        expect(king_of_hearts.suit).to eq('hearts')
        expect(two_of_hearts.suit).to eq('hearts')
        expect(ten_of_spades.suit).to eq('spades')
        expect(eight_of_diamonds.suit).to eq('diamonds')
        expect(five_of_clubs.suit).to eq('clubs')
    end
end
