def binary_search(number, array)
    og_array = array.clone
    found = false
    temp = true
    while !found && array.length > 0 && temp
        n = array.length
        puts n
        mid = array.length/2
        puts mid
        puts array[mid]
        if array[mid] == number 
            puts "#{number} is in the array at position #{og_array.index(number)}"
            found = true
        elsif array[mid] > number 
            if n > 1
                array = array[0..mid-1]
            else
                temp = false
            end
        elsif array[mid] < number 
            array = array[mid+1..n-1]
        end
    end
    if !found 
        puts "Not in array"
    end
end

l = [2,3,5,7,9,11,13,17,19,23,29,31,37]
binary_search(11,l)