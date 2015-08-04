The Optimization Challenge

Objective: 
Create a trading module. Each customer has a cash balance and a target portfolio with specific allocations per asset.  The job of the trading module is to buy shares to bring the actual allocation of investments as close as possible to the target allocations without spending more money than the customer actually has.

Walkthrough:
Each customer has an Account, and under each account are Allocation objects that hold te specific allocation per asset for that customer. Assets are global objects created based on the asset name and price.

Customers' allocations are then calculated based the target percentage they are looking for their portfolios to have of each asset. Once allocations are calculated,I optimize the buys for each customer. Taking into the amount of cash leftover in the account, this method calculates how many more of each asset can be bought with it. Then, it calculates which of these additional buys will bring the total purchase closest to the total cash value of the account. Finding this, it makes the additional purchases.

Trade-Offs:
The main trade-off here is that in optimizing, I am purchasing more the one asset that will bring me closest to the account's cap spending. This is instead of finding a collection of different assets to might bring me even closer to the cash amount. This also skews the  asset chosen for further purchases against its targets. 

Seeing the results based on the inputs, however, I find that the optimal set of buys has been achieved as each aspect of the challenge was met: (1) keeping allocations as close as possible to their targets and (2) not spending more money than the client already has. 

If refactoring, I would look into dynamic programming options like the KnapSack or Bin Packing algorthimn to find a more optimal set of purchases.

To run in Terminal:
1) To get the optimal set of buys, type ruby allocation_challenge.rb.
2) To run tests, type ruby tests.rb.
