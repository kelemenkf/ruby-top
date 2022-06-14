def fibs(n)
    result = [0,1]
    for i in (0..n-3)
        ter = result[i] + result[i+1]
        result << ter
    end
    return result
end

def fibs_rec(n)
    #what is the base case here? 0 and 1
    #I call a method it returns something that value is passed into the function again
    if n == 0
        return [0]
    elsif n == 1
        return [0,1]
    else 
        array = fibs_rec(n-1)
        array << array[-2] + array[-1]
    end
end

p fibs_rec(8)