require 'csv'
require './lib/asset.rb'
require './lib/allocation.rb'
require './lib/account.rb'

$assets = []
accounts = [] 

# New Assets created based on asset_prices.csv. These placed in a globally accessible array, since asset prices are needed to calculate numerous things.
CSV.foreach("data/asset_prices.csv", {:headers => true}) do |col|
  $assets << Asset.new(col[0], col[1].to_f)
end

# New Accounts created based on cash.csv
CSV.foreach("data/cash.csv",{:headers => true}) do |col|
  accounts << Account.new(col[0].to_i, col[1].to_i)
end

# New Allocations created based on target_allocations.csv and placed under the relevant account.
CSV.foreach("data/target_allocations.csv",{:headers => true}) do |col|
  accounts.find{ |account| account.allocations << Allocation.new(col[1], col[2].to_i) if col[0].to_i == account.id}
end

#After all the inputs are added, the optimal allocation of assets based on each customer's targets is calcuated. 
accounts.each do |account|
  account.allocate
  account.print_results
end