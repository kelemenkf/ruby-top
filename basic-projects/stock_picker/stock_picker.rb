def stock_picker(prices)
    prices = prices.reverse
    differences = []

    while prices.length > 0
        for i in (1..prices.length-1)
            diff = prices[0] - prices[i]
            differences << diff
            if differences.max == diff
                a = prices.reverse.index(prices[0])
                b = prices.reverse.index(prices[i])
            end
        end
        prices.shift
    end

    output = [b,a]
    p output
end

prices = [17,3,6,9,15,8,6,1,10]
stock_picker(prices)
