def stock_picker(stock_prices)
	best_profit = stock_prices[1] - stock_prices[0]
	best_buy_day, best_sell_day = 0, 1

	(0...stock_prices.length - 1).each do |day|
		stock_prices_left = stock_prices[day + 1, stock_prices.length - 1]
		cur_best_profit = stock_prices_left.max - stock_prices[day]
		if cur_best_profit > best_profit
			best_profit = cur_best_profit
			best_buy_day = day
			best_sell_day = stock_prices_left.index(stock_prices_left.max) + day + 1
		end
	end
	[best_buy_day, best_sell_day]
end

if $PROGRAM_NAME == __FILE__
	p stock_picker([17,3,6,9,15,8,6,1,10])
end
