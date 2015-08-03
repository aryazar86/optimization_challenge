class Account

  attr_accessor :id, :cash, :allocations

  def initialize(id, cash)
    @id = id
    @cash = cash
    @allocations = []
  end

  def spent
    total = 0
    @allocations.each do |allocation|
      $assets.find { |asset| total += asset.price * allocation.purchased if asset.name == allocation.asset_name.to_s}
    end
    return total
  end

  def leftover
    return @cash - self.spent
  end

  def allocate
    @allocations.each { |allocation| allocation.buy(self.cash) }
    self.optimize
  end

  def optimize
    
    closest = []
    $assets.each do |asset|
      shares_to_buy = ((self.leftover / asset.price).floor.to_i)
      closest << {name: asset.name, number_of_stocks: shares_to_buy, how_close: self.leftover - (asset.price * shares_to_buy) }
    end

    best_option = (closest.sort! {|x, y| x[:how_close] <=> y[:how_close] }).first
    @allocations.find { |allocation| allocation.add(best_option[:number_of_stocks]) if best_option[:name].to_s == allocation.asset_name }
  end

  def print_results
    total = self.spent
    puts "Account #{@id}"
    puts "Cash: $#{@cash} \n Actual Spending: $#{total} \n Remaining Balance: $#{@cash - total}"
    puts "\nTargets Allocations:\n"
    @allocations.each do |allocation|
      percent_purchased = allocation.percent_purchased(total)
      puts "Asset #{allocation.asset_name} \n Target Allocation: #{allocation.target}% \n Actual Allocation: #{percent_purchased}% \n Difference: #{allocation.difference(percent_purchased)}% \n\n"
    end
    puts "\n\n"
  end

end