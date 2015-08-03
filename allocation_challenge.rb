require 'csv'
require './lib/asset.rb'
require './lib/allocation.rb'
require './lib/account.rb'

$assets = []
accounts = [] 

CSV.foreach("data/asset_prices.csv", {:headers => true}) do |col|
  $assets << Asset.new(col[0], col[1].to_f)
end

CSV.foreach("data/cash.csv",{:headers => true}) do |col|
  accounts << Account.new(col[0].to_i, col[1].to_i)
end

CSV.foreach("data/target_allocations.csv",{:headers => true}) do |col|
  accounts.find{ |account| account.allocations << Allocation.new(col[1], col[2].to_i) if col[0].to_i == account.id}
end

accounts.each do |account|
  account.allocate
  account.print_results
end