require './card.rb'
deck = []

12.times do |n|
  deck.push(Card.new(n+1, "Diamonds"))
  deck.push(Card.new(n+1, "Hearts"))
  deck.push(Card.new(n+1, "Clubs"))
  deck.push(Card.new(n+1, "Keegans"))
end

player_hand = []
cpu_hand = []

7.times do |n|
  r = rand(deck.length)
  player_hand.push(deck[r])
  deck.delete_at(r)
end
7.times do |n|
  r = rand(deck.length)
  cpu_hand.push(deck[r])
  deck.delete_at(r)
end

continue = true
last8 = false
while continue
  turncard = deck.shift
  counter = 0
  # :D
  # Good code r8 8/8 m8
  player_hand.each do |cd|
    counter += 1
    puts "#{counter}: #{cd.id}"
  end
  puts "Card this turn: #{turncard.id}"
  puts "What card do you want to put down? (If you can't do anything, type draw)"
  STDOUT.flush
  card = gets.chomp
  # end :D
  c = false
  while !c
    if last8
      if player_hand[(card.to_i)-1].suit == "Diamonds"
        deck.push(player_hand[(card.to_i)-1])
        player_hand.delete_at((card.to_i)-1)
        c = true
        last8 = false
      end
    else
      if player_hand[(card.to_i)-1].number == 8
        deck.push(player_hand[(card.to_i)-1])
        player_hand.delete_at((card.to_i)-1)
        c = true
        puts "What is the desired suit next turn?"
        STDOUT.flush
        suit = gets.chomp
        last8 = true
        # D:
        # r8 maybe 4/8?
      elsif player_hand[(card.to_i)-1].number == turncard.number || player_hand[(card.to_i)-1].suit == turncard.suit
        deck.push(player_hand[(card.to_i)-1])
        player_hand.delete_at((card.to_i)-1)
        # end D:
        c = true
      elsif card == "draw"
        player_hand.push(deck[0])
        deck.delete_at(0)
        counter = 0
        player_hand.each do |cd|
          counter += 1
          puts "#{counter}: #{cd.id}"
        end
        STDOUT.flush
        card = gets.chomp
      else
        puts "That card is invalid, put an 8, or a card of the same number/suit."
        STDOUT.flush
        card = gets.chomp
      end
    end
  end

  puts "**********************************************"

  turncard = deck.shift
  puts "Card for CPU: #{turncard.id}"
  STDOUT.flush

  counter = 0
  card_played = false
  while !card_played
    cpu_hand.each do |cd|
      if card_played == false
        if last8
          if cd.suit == suit
            puts "CPU played #{cd.id}."
            deck.push(cpu_hand[counter])
            cpu_hand.delete_at(counter)
            card_played = true
            last8 = false
          end
        else
          if cd.number == 8
            puts "CPU played #{cd.id}."
            deck.push(cpu_hand[counter])
            cpu_hand.delete_at(counter)
            card_played = true
            suit = "Diamonds"
            last8 = true
          elsif cd.number == turncard.number || cd.suit == turncard.suit
            puts "CPU played #{cd.id}."
            deck.push(cpu_hand[counter])
            cpu_hand.delete_at(counter)
            card_played = true
          end
        end
      end
      counter += 1
    end
    if card_played == false
      puts "CPU draws a card."
      cpu_hand.push(deck[0])
      deck.delete_at(0)
    end
  end

  puts "**********************************************"

  if player_hand.length == 0
    puts "Player wins!"
    continue = false
  end
  if cpu_hand.length == 0
    puts "CPU wins!"
    continue = false
  end
end
