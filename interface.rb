module Interface
  module_function

  def ask_player_name

    puts 'Введите имя пользователя:'
    gets.chomp
  end


  def show_info(round)
    puts "Player: #{round.player_cards}, #{round.player_score}"
    puts "Dealer: #{round.dealer_cards}, #{round.dealer_score}"
  end

  def ask_player_decision
    puts 'Введите 1 если вы хотите взять еще одну карту'
    puts 'Введите 0 или любой текст чтобы передать ход дилеру'
    des = gets.chomp.to_i
    return :take_card if des == 1
    :dealer_turn
  end

  def show_round_result(round)
    puts "Карты игрока: #{round.player_cards}, счет: #{round.player_score}"
    puts "Карты дилера: #{round.dealer_cards}, счет: #{round.dealer_score}"

    if round.finished?
      result = case round.result
                 when :player_wins then 'Вы выиграли'
                 when :draw        then 'Ничья'
                 when :dealer_wins then 'Дилер выиграл'
                 else 'Ошибка'
               end
      puts "Result: #{result}"
    end
  end

  def show_player_balance(balance)
    puts "Ваш баланс: #{balance}"
  end

  def ask_one_more?
    puts 'Введите 1 если вы хотите сыграть еще одну раздачу'
    puts 'Введите 0 или любой текст чтобы закончить игру'
    gets.chomp == '1'
  end

  def say_goodbye(balance: , name:)
    puts "Рады были с вами играть, #{name}, ваш баланс #{balance}"
  end

  def new_round
    puts 'Новый раунд'
  end

  def welcome_message
    puts 'Добрый день, хорошей вам игры в BlackJack'
  end

end