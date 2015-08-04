class Account

  attr_accessor :id, :cash, :allocations

  def initialize(id, cash)
    @id = id
    @cash = cash
    @allocations = []
  end

  #Calculates how much money has been spent by the allocation
  def spent
    total = 0
    @allocations.each do |allocation|
      $assets.find { |asset| total += asset.price * allocation.purchased if asset.name == allocation.asset_name.to_s}
    end
    return total
  end

  #Calcutes the remaining amount of cash left
  def leftover
    return @cash - self.spent
  end

  #Has each target allocation calculated, and then optimized
  def allocate
    @allocations.each { |allocation| allocation.buy(self.cash) }
    self.optimize
  end

  # Once allocations are calculated, this method attempts to optimize the buys. It takes the amount of cash leftover in the account and calculates how many of each asset can be bought. Then, it calculates which additional buy will bring the total purchase closest to the total cash value of the account. Finding this, it makes the additional purchases.
  def optimize
    
    closest = []
    $assets.each do |asset|
      shares_to_buy = ((self.leftover / asset.price).floor.to_i)
      closest << {name: asset.name, number_of_stocks: shares_to_buy, how_close: self.leftover - (asset.price * shares_to_buy) }
    end

    best_option = (closest.sort! {|x, y| x[:how_close] <=> y[:how_close] }).first
    @allocations.find { |allocation| allocation.add(best_option[:number_of_stocks]) if best_option[:name].to_s == allocation.asset_name }
  end

  # Prints the results of the buys
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