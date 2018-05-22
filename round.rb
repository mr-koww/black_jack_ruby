require_relative 'deck'

class Round

  attr_reader   :player_score, :dealer_score, :player_cards, :result

  def initialize
    @cards = Deck.generate
    @player_cards = []
    @dealer_cards = []
    @player_score = 0
    @dealer_score = 0
    @finished = false
    initial_turn
  end

  def player_turn(decision)
    return if finished?
    case decision
      when :take_card
        player_take_card
      when :dealer_turn
        dealer_turn
    end
  end

  def finished?
    @finished
  end

  def dealer_cards
    finished? ? @dealer_cards : [@dealer_cards[0], '***']
  end

  private

  def score(cards)
    amount = cards.map(&:to_i).sum
    amount += cards.select{|card| ['J', 'Q', 'K'].include? card[0] }.count * 10
    amount += cards.select{|card| ['A'].include? card[0] }.count * 11
    count_aces = cards.select{|card| card[0] == 'A'}.count
    count_aces.times do
      amount -= 10 if amount > 21
    end

    amount
  end

  def initial_turn
    2.times do
      @player_cards << @cards.delete(@cards.sample)
      @dealer_cards << @cards.delete(@cards.sample)
    end
    calc_player_score
  end

  def player_take_card
    player_cards << @cards.delete(@cards.sample)
    calc_player_score
    check_result_after_player_turn
  end

  def dealer_turn
    loop do
      calc_dealer_score
      break if dealer_score >= 17
      @dealer_cards << @cards.delete(@cards.sample)
    end
    check_result_after_dealer_turn
  end

  def calc_player_score
    @player_score = score(@player_cards)
  end

  def calc_dealer_score
    @dealer_score = score(@dealer_cards)
  end

  def check_result_after_player_turn
    if @player_score > 21
      @result = :dealer_wins
      @finished = true
    end
  end

  def check_result_after_dealer_turn

    if @dealer_score > 21
      @result = :player_wins
      @finished = true
      return
    end

    delta = @player_score - @dealer_score
    case
      when delta > 0
        @result = :player_wins
      when delta == 0
        @result = :draw
      when delta < 0
        @result = :dealer_wins
    end
    @finished = true
  end

end