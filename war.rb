require './card.rb'

thirteen = []
number = 1

13.times do
  thirteen.push(number)
  number += 1
end

deck = []

13.times do |n|
  deck.push(Card.new((thirteen[n]), "Diamonds"))
  deck.push(Card.new((thirteen[n]), "Hearts"))
  deck.push(Card.new((thirteen[n]), "Clubs"))
  deck.push(Card.new((thirteen[n]), "Spades"))
end

player_hand = []
cpu_hand = []

26.times do |n|
  r = rand(deck.length)
  player_hand.push(deck[r])
  deck.delete_at(r)
end
26.times do |n|
  r = rand(deck.length)
  cpu_hand.push(deck[r])
  deck.delete_at(r)
end

continue = true
puts "Player has #{player_hand.length} cards."
puts "CPU has #{cpu_hand.length} cards."
while continue == true
  STDOUT.flush
  if player_hand[0].number < cpu_hand[0].number
    player_card = player_hand[0]
    cpu_card = cpu_hand[0]
    puts "Player card: #{player_card.id}"
    puts "CPU card: #{cpu_card.id}"
    player_hand.delete_at(0)
    cpu_hand.delete_at(0)
    cpu_hand.push(player_card)
    cpu_hand.push(cpu_card)
  elsif player_hand[0].number > cpu_hand[0].number
    player_card = player_hand[0]
    cpu_card = cpu_hand[0]
    puts "Player card: #{player_card.id}"
    puts "CPU card: #{cpu_card.id}"
    STDOUT.flush
    player_hand.delete_at(0)
    cpu_hand.delete_at(0)
    player_hand.push(player_card)
    player_hand.push(cpu_card)
  elsif continue
    card_spot = 0
    if continue
      while continue && player_hand.length >= 5 && cpu_hand.length >= 5 && player_hand[card_spot].number == cpu_hand[card_spot].number
        player_card = player_hand[card_spot]
        cpu_card = cpu_hand[card_spot]
        puts "Player card: #{player_card.id}"
        puts "CPU card: #{cpu_card.id}"
        puts "War!"
        card_spot += 4
        STDOUT.flush
        if player_hand[card_spot] != nil && cpu_hand[card_spot] != nil
          if player_hand[card_spot].number > cpu_hand[card_spot].number
            cpu_hand[0..card_spot].each do |x|
              player_hand.push(x)
            end
            player_hand[0..card_spot].each do |x|
              player_hand.push(x)
            end
            (card_spot + 1).times do
              player_hand.delete_at(0)
              cpu_hand.delete_at(0)
            end
          elsif player_hand[card_spot].number < cpu_hand[card_spot].number
            player_hand[0..card_spot].each do |x|
              cpu_hand.push(x)
            end
            cpu_hand[0..card_spot].each do |x|
              cpu_hand.push(x)
            end
            (card_spot + 1).times do
              player_hand.delete_at(0)
              cpu_hand.delete_at(0)
            end
          end
        else
          continue = false
        end
        if player_hand.length < 5
          puts "You lose!"
          continue = false
        end
        if cpu_hand.length < 5
          puts "You win!"
          continue = false
        end
      end
      if player_hand.length < 5
        puts "You lose!"
        continue = false
      end
      if cpu_hand.length < 5
        puts "You win!"
        continue = false
      end
    end
  end
  puts "Player has #{player_hand.length} cards."
  puts "CPU has #{cpu_hand.length} cards."
  player_hand.shuffle!
  cpu_hand.shuffle!
  STDOUT.flush
  # response = gets.chomp
  # if response != "yes" && response != "y"
  #   continue = false
  # end
  if player_hand.length < 5
    puts "You lose!"
    continue = false
  end
  if cpu_hand.length < 5
    puts "You win!"
    continue = false
  end
end
