def merge_sort(array)
    n = array.length
    m = n/2

    if n < 2
        array
    else
        left = array[0...m]
        left = merge_sort(left)
        right = array[m..-1]
        right = merge_sort(right)
        array = []
        while [left,right].none?(&:empty?)
            array << (left[0] < right[0] ? left.shift : right.shift)
        end
        return array + left + right
    end
end

l = [3,2,4,5]
puts merge_sort(l)