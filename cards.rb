class Card
    attr_reader :name, :value ,:suit, :icon
    
    def initialize(name, suit, value, icon)
        @name = name
        @suit = suit
        @value = value
        @icon = icon

        @card = TTY::Box.frame(width: 5, height: 4, align: :center, border: :thick,title: {top_left: " #{@icon} ", bottom_right: " #{@icon} "}) do "#{@name}" end
    end

    def inspect
        puts "#{@name.capitalize} of #{suit} #{@icon} - Value : #{value} and it looks like: "
        puts "#{@card}"
    end

    def to_s
        @card
    end

end

class Ace < Card
    def initialize(name, suit, icon)
        super(name, suit, 11, icon)
    end

    def value_change
        @value = @value == 1 ? 11 : 1
    end
end