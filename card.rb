class Card
  def initialize(number, suit)
    @number = number
    @suit = suit
  end

  attr_accessor :number, :suit

  def id
    "#{number} of #{suit}"
  end
end
