class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 2

    pivot = array.first
    left = array.select { |el| el < pivot }
    right = array.select { |el| el > pivot }

    self.sort1(left) + pivot + self.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }

    return array if length < 2

    pivot = partition(array, start, length, &prc)
    left = pivot - start
    right = length - (left+1)

    sort2!(array, start, left, &prc)
    sort2!(array, pivot + 1, right, &prc)

    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }

    pivot = start

    ((start+1)...(start+length)).each do |i|

      val = array[i]
      if prc.call(array[pivot], val) >= 1
        array[i] = array[pivot + 1]
        array[pivot + 1] = array[pivot]
        array[pivot] = val
        pivot += 1
      end

    end

    pivot

  end
end
