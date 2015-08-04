The Optimization Challenge

Objective: 
Create a trading module. Each customer has a cash balance and a target portfolio with specific allocations per asset.  The job of the trading module is to buy shares to bring the actual allocation of investments as close as possible to the target allocations without spending more money than the customer actually has.

Walkthrough:
Each customer has an Account, and under each account are Allocation objects that hold te specific allocation per asset for that customer. Assets are global objects created based on the asset name and price.

Customer's allocations are then calculated based on the targets set by each asset allocation. Once allocations are calculated, an "optimize" attempts to optimize the buys for each customer. It takes the amount of cash leftover in the account and calculates how many of each asset can be bought. Then, it calculates which additional buy will bring the total purchase closest to the total cash value of the account. Finding this, it makes the additional purchases.

Trade-Offs:
The main trade-off here is that in optimzing, I am purchasing more the one asset that will bring me closest to the account cash reserves. This is in place of finding a collection of different assets to might bring me even closer to the cash amount.

