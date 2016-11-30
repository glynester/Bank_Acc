##**BRIEF**
Given a client makes a deposit of 1000 on 10-01-2012 And a deposit of 2000 on 13-01-2012 And a withdrawal of 500 on 14-01-2012 When she prints her bank statement Then she would see  

```
date       || credit || debit   || balance  
14/01/2012 ||        || 500.00  || 2500.00  
13/01/2012 || 2000.00||         || 3000.00   
10/01/2012 || 1000.00||         || 1000.00     
```

You should be able to interact with the your code via IRB. (You don't need to implement a command line interface that takes input from STDIN.)
Deposits, withdrawal.  
Account statement (date, amount, balance) printing.  
Data can be kept in memory (it doesn't need to be stored to a database or anything).  

##**APPROACH:**  
This app is built using Ruby.  
Interaction is via IRB.  
Rspec is used for testing the app.


##**DOWNLOADING AND RUNNING CODE:**  

```
$ git clone https://github.com/glynester/Bank_Acc
$ cd Bank_Account  
$ irb
$ load './lib/account.rb'
```
Type the commands contained in the instructions sections into the console in an irb (or pry) session.


##**INSTRUCTIONS**
<strong>To create an account:</strong>  
The account name parameter is optional.
```
acc = Account.new("A Person")
```

<strong>To create a transaction:</strong>  
There are 2 types of transactions: 1) deposits and 2) withdrawals.
If you omit the date parameter, the date today will default in.
Date format is dd/mm/yyyy.
```
dep1 = Deposit.new(25.38)  
wdraw1 = Withdrawal.new(100, "27/02/2016")
```  

<strong>To add the transactions to the account:</strong>  
The transaction can be created in the parameters section of the "add_trans" method or a named transaction instance can be included as a parameter.   
Transactions can be added singly or multiple transactions can be added at once.  
```
acc.add_trans(dep1)  
acc.add_trans(wdraw1)
acc.add_trans(Deposit.new(32.21))
acc.add_trans(Withdrawal.new(86.99),Deposit.new(154.75))
```  

<strong>To get a balance:</strong>  
Enter a parameter to get a certain number of transactions
```
acc.balance  
puts acc.balance(3)  
acc.statement  
```

<strong>To create a statement:</strong>  
Transactions are printed to the screen in the order they were created - the last transaction entered appears at the top of the statement.
To reverse the order of the statement provide a parameter of "rev".  
```
acc.statement
acc.statement(rev)
```  

###Script (to type into the console):  
```
irb
load './lib/account.rb'
acc = Account.new("A Person")  
dep1 = Deposit.new(2225.38, "02/01/2016")  
wdraw1 = Withdrawal.new(124.06, "28/02/2016")
acc.add_trans(dep1)
acc.add_trans(wdraw1)
acc.add_trans(Withdrawal.new(304.8))  
print acc.balance  
acc.statement  
```
###Expected output of Script

```
date           || credit   || debit    || balance  
29/11/2016     ||          ||    304.80||   1796.52  
28/02/2016     ||          ||    124.06||   2101.32  
02/01/2016     ||   2225.38||          ||   2225.38  
```

##**RUNNING TESTS:**  

```
$ cd Bank_Account
$ rspec
```
