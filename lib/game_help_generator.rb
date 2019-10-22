class GameHelpGenerator
  # Сколько всего виртуальных зрителей в игре (в процентах получается)
  TOTAL_WATCHERS = 100

  # Возвращает hash c массивом ключей keys и значениями — распределением в
  # процентах. Ключ правильного ответа (correct_key), будет выбран с большим
  # весом.
  def self.audience_distribution(keys, correct_key)
    result_array = []

    keys.each do |key|
      if key == correct_key
        result_array << rand(45..90)
      else
        result_array << rand(1..60)
      end
    end

    # Нормализуем массив
    sum = result_array.sum
    result_array.map! { |v| TOTAL_WATCHERS * v / sum }

    # Возвращаем хэш, собранный из массива ключей и значений
    Hash[keys.zip(result_array)]
  end

  def self.friend_call(keys, correct_key)
    # C ~80% вероятностью выбираем правильный ключ, и с 20% - неправильный
    key = (rand(10) > 2) ? correct_key : keys.sample

    I18n.t(
      'game_help.friend_call', variant: key.upcase,
      name: I18n.t('game_help.friends').sample
    )
  end
end
