require_relative 'interface'
require_relative 'round'

class Game
  INITIAL_PLAYER_BALANCE = 100
  ROUND_RATE = 10

  attr_reader :player_name, :player_balance, :current_round

  def initialize
    @player_balance = INITIAL_PLAYER_BALANCE
    @player_name = Interface.ask_player_name
  end

  def controller
    Interface.welcome_message

    while player_balance > ROUND_RATE
      Interface.new_round

      bet_player_balance
      @current_round = Round.new

      until current_round.finished?
        Interface.show_info(current_round)
        decision = Interface.ask_player_decision
        current_round.player_turn(decision)
      end

      update_player_balance

      Interface.show_round_result(current_round)
      Interface.show_player_balance(player_balance)

      one_more = Interface.ask_one_more?
      break unless one_more
    end
    Interface.say_goodbye(balance: player_balance, name: player_name)
  end

  private

  def update_player_balance
    return unless current_round.finished?

    @player_balance += 2 * ROUND_RATE if current_round.result == :player_wins
    @player_balance +=     ROUND_RATE if current_round.result == :draw
  end

  def bet_player_balance
    @player_balance -= ROUND_RATE
  end
end
