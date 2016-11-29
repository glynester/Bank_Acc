class Transaction
  require 'date'

  attr_reader :amnt, :trans_type, :date

  def initialize(trans_type, amnt, date=Time.now.strftime("%d/%m/%Y"))
    @trans_type = trans_type
    @amnt = amnt
    if validate_date(date)
      @date = date
    else
      raise "Date format is wrong"
    end
  end

  private
  def validate_date(date)
            # my_date = Date.strptime("12/22/2011", "%m/%d/%Y")
    # my_date = Date.strptime(date, "%d/%m/%Y")
    # my_date ? true : false
    puts "Date value tested"
    return true
  end
end

class Deposit < Transaction
  def initialize(amnt, date=Time.now.strftime("%d/%m/%Y"))
    @trans_type = "deposit"
    @amnt = amnt
    @date = date
  end
end

class Withdrawal < Transaction
  def initialize(amnt, date=Time.now.strftime("%d/%m/%Y"))
    @trans_type = "withdrawal"
    @amnt = amnt
    @date = date
  end
end

class Account
  def initialize(name)
    @name = name
    @balance = 0;
    @transactions = []
  end

  def add_trans(trans)
    @transactions << trans
  end

  def balance
      @balance = 0
      @transactions.each{|trans|
        if trans.trans_type == "deposit"
          @balance += trans.amnt
        elsif trans.trans_type == "withdrawal"
          @balance -= trans.amnt
        end
      }
      @balance
  end

  def statement
    puts "date       || credit || debit   || balance"
    @transactions.each{|trans|
      puts "#{trans.date}    || "
    }
    # puts balance
  end
end

acc = Account.new("A Person")
acc.add_trans(Deposit.new(32.21))
dep1 = Deposit.new(25.38)
acc.add_trans(dep1)
puts acc.balance
# puts dep1.amnt
# puts dep1.trans_type
# puts dep1.date
wdraw1 = Withdrawal.new(100, "31/2/2016")
acc.add_trans(wdraw1)
puts wdraw1.amnt
puts acc.balance

acc.statement
# puts dep2.date


# dep1 = Transaction.new("deposit", 25.38)
# puts dep1.amnt
# puts dep1.trans_type
# puts dep1.date
# dep2 = Transaction.new("deposit", 25.38, 31/2/2016)
# puts dep2.date
