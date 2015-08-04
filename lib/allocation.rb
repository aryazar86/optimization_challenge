
class Allocation

  attr_accessor :asset_name, :target, :purchased

  def initialize(asset_name, target)
    @asset_name = asset_name
    @target = target
    @purchased = 0
  end

  def add(amount)
    @purchased += amount
  end

  # Calculates the number of asset purchases can be made in order to meet the target for said asset set by the customer.
  def buy(cash)
    @purchased = (@target.to_f/100 * cash / ($assets.find{ |asset| asset.name.to_s == @asset_name }).price).floor.to_i
  end

  # Calculates the actual percentage of assets purchased
  def percent_purchased(total)
    actual_allocation = ((($assets.find{ |asset| asset.name.to_s == asset_name }).price * @purchased) / total) * 100
  end

  # Calculates the difference between the actual and target asset purchase percentages
  def difference(percent_purchased)
    return percent_purchased - @target
  end


end