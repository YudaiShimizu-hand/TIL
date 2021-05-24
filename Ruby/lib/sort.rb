def selectionSortFunc(value)
    i = 0
    while i < value.length
      minNumber = i # 初期値
      staNumber = i + 1 # 初期値
      # 最小値を検索する処理
      while staNumber < value.length
        if value[staNumber] < value[minNumber]
          minNumber = staNumber
        end
        staNumber += 1
      end
      # 最小値を並びかえる処理
      value[i], value[minNumber] = value[minNumber], value[i]
      i += 1
    end
    return value
  end
  numbers = [10, 8, 3, 5, 2, 4, 11, 18, 20, 33]
  p selectionSortFunc(numbers)