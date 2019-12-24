# Vending Machine Simulator

The vending machine, once a product is selected and the appropriate amount of
money (coins) is inserted, should return that product. It should also return
change (coins) if too much money is provided or ask for more money (coins) if
there is not enough. Keep in mind that you need to manage the scenario where
the item is out of stock or the machine does not have enough change to return
to the customer. 

## Usage

### How to run it?

In order to run the vending machine, please, run the `main.rb` script in your terminal:

```shell
$ ruby main.rb
```

Once the machine is run it tells you the next information:

- what kind of coins it supports
- how many coins it has in its bank
- what products are available for selling

If you want to buy some product, please, entere the ID of it and then insert
the needed amount of coins in order to purchase the product. Once you inserted
enough coins you get the product and the change (if you inserted more coins
than it's needed to cover the product's price).

Each time when the application is started the machine has different
amount of coins and different amount of products.

Please, consider the following output as an example:

```
% ruby main.rb                                                                                                                                                                                                                                ~/Work/vending_machine
> Hi, mate! Welcome to my vending machine!

> I support the following coins:
  25c
  50c
    1
    2
    5

> I have the following coins in my bank:
  5x   50c
  8x     1
  1x     2
  9x     5

> That's what I have for you:
1       2x Nachos                              $2.0
2       4x Animal cracker                       75¢
3       6x Potato chips                       $2.25
4       4x Cashews                             $4.5
5       9x Popcorn                            $1.75
6       0x Chocolate chip cookie               $1.0

> What would you like to purchase? (enter `cancel` or `exit` to quit): 10

> There is no product with id #10

> I have the following coins in my bank:
  5x   50c
  8x     1
  1x     2
  9x     5

> That's what I have for you:
1       2x Nachos                              $2.0
2       4x Animal cracker                       75¢
3       6x Potato chips                       $2.25
4       4x Cashews                             $4.5
5       9x Popcorn                            $1.75
6       0x Chocolate chip cookie               $1.0

> What would you like to purchase? (enter `cancel` or `exit` to quit): 6

> No more product with id #6

> I have the following coins in my bank:
  5x   50c
  8x     1
  1x     2
  9x     5

> That's what I have for you:
1       2x Nachos                              $2.0
2       4x Animal cracker                       75¢
3       6x Potato chips                       $2.25
4       4x Cashews                             $4.5
5       9x Popcorn                            $1.75
6       0x Chocolate chip cookie               $1.0

> What would you like to purchase? (enter `cancel` or `exit` to quit): 2

> It's time to pay! Please, insert coins in total amount of 75¢
> Insert the coin (75¢ left): : 25c
> Insert the coin (50¢ left): : 1

> Please, take your change:
  1x   50c

Thank you for your choice! bon appétit!

> I have the following coins in my bank:
  4x   50c
  9x     1
  1x     2
  9x     5
  1x   25c

> That's what I have for you:
1       2x Nachos                              $2.0
2       3x Animal cracker                       75¢
3       6x Potato chips                       $2.25
4       4x Cashews                             $4.5
5       9x Popcorn                            $1.75
6       0x Chocolate chip cookie               $1.0

> What would you like to purchase? (enter `cancel` or `exit` to quit): exit
>>>>>>>>>>
> Bye, mate! Don't forget to visit me soon
```

The example with more complex change calculations:

```
% ruby main.rb                                                                                                                                                                                                                                ~/Work/vending_machine
> Hi, mate! Welcome to my vending machine!

> I support the following coins:
  25c
  50c
    1
    2
    5

> I have the following coins in my bank:
  7x   25c
  1x   50c
  4x     1
  1x     5

> That's what I have for you:
1       3x Nachos                              $2.0
2       8x Animal cracker                       75¢
3       2x Potato chips                       $2.25
4       9x Cashews                             $4.5
5       3x Popcorn                            $1.75
6       8x Chocolate chip cookie               $1.0

> What would you like to purchase? (enter `cancel` or `exit` to quit): 2

> It's time to pay! Please, insert coins in total amount of 75¢
> Insert the coin (75¢ left): : 5

> Please, take your change:
  4x     1
  1x   25c

Thank you for your choice! bon appétit!

> I have the following coins in my bank:
  6x   25c
  1x   50c
  2x     5

> That's what I have for you:
1       3x Nachos                              $2.0
2       7x Animal cracker                       75¢
3       2x Potato chips                       $2.25
4       9x Cashews                             $4.5
5       3x Popcorn                            $1.75
6       8x Chocolate chip cookie               $1.0

> What would you like to purchase? (enter `cancel` or `exit` to quit): exit
>>>>>>>>>>
> Bye, mate! Don't forget to visit me soon
```

The example when there are no enough coins to provide the required change:

```
% ruby main.rb                                                                                                                                                                                                                                ~/Work/vending_machine
> Hi, mate! Welcome to my vending machine!

> I support the following coins:
  25c
  50c
    1
    2
    5

> I have the following coins in my bank:
  7x   50c
  2x     1
  1x     2

> That's what I have for you:
1       6x Nachos                              $2.0
2       0x Animal cracker                       75¢
3       5x Potato chips                       $2.25
4       3x Cashews                             $4.5
5       5x Popcorn                            $1.75
6       4x Chocolate chip cookie               $1.0

> What would you like to purchase? (enter `cancel` or `exit` to quit): 5

> It's time to pay! Please, insert coins in total amount of $1.75
> Insert the coin ($1.75 left): : 5

> Please, take your change:
  1x     2
  1x     1
> Please, take into account that I don't have enough coins to provide you a change.
> The amount of money which I ought you is 25¢

Thank you for your choice! bon appétit!

> I have the following coins in my bank:
  7x   50c
  1x     1
  1x     5

> That's what I have for you:
1       6x Nachos                              $2.0
2       0x Animal cracker                       75¢
3       5x Potato chips                       $2.25
4       3x Cashews                             $4.5
5       4x Popcorn                            $1.75
6       4x Chocolate chip cookie               $1.0

> What would you like to purchase? (enter `cancel` or `exit` to quit): exit
>>>>>>>>>>
> Bye, mate! Don't forget to visit me soon
```

### Tests

The significant part of the code base is covered by the unit tests which could
be run using the following command:

```
$ rake test
```
