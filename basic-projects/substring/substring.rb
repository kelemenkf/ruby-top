def substrings(word, dictionary)
    result = Hash.new(0)
    dictionary.each do |string|
        if word.include?(string)
            result[string] += 1
        end
    end 
    return result
end


dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
p substrings("Howdy partner, sit down! How's it going?", dictionary)
