def selectionSortFunc(array)
    i = 0
    while i < array.length
      minNumber = i # 初期値
      startNumber = i + 1 # 初期値
      # 最小値を検索する処理
      while startNumber < array.length
        if array[startNumber] < array[minNumber]
          minNumber = startNumber
        end
        startNumber += 1
      end
      # 最小値を並びかえる処理
      array[i], array[minNumber] = array[minNumber], array[i]
      i += 1
    end
    return array
  end
  numbers = [10, 8, 3, 5, 2, 4, 11, 18, 20, 33]
  p selectionSortFunc(numbers)