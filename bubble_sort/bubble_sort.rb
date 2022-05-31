def bubble_sort(array)
    for j in (1..array.length)
        for i in (0..array.length-2)
            if array[i] > array[i+1]
                temp = array[i]
                array[i] = array[i+1]
                array[i+1] = temp
            end
        end
    end
    return array
end

p bubble_sort([4,3,78,2,0,2])
#what is swapping? taking the number at index i and setting it to i - 1 if the previous one is larger
#and at the same time setting 

