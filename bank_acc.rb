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
    # @statement = []
  end

  def add_trans(trans)
    @transactions << trans
  end
#XXXXXXXXXXXXXXXXXXXXXX
  def balance(no_of_trans = @transactions.length)
      @balance = 0
      trans_sel = @transactions[0...no_of_trans]
      trans_sel.each{|trans|
        if trans.trans_type == "deposit"
          @balance += trans.amnt
        elsif trans.trans_type == "withdrawal"
          @balance -= trans.amnt
        end
      }
      @balance
  end

  def statement(order = "down")
    if order == "down"
      statement_lines = generate_statement.reverse
    elsif order == "rev"
      statement_lines = generate_statement
    end
    statement_lines.each{|t|
      date = t[0];credit=t[1];debit=t[2];bal=t[3]
      printf("%-15s||#{value(credit)}||#{value(debit)}||#{value(bal)}\n", date, blank(credit), blank(debit), bal)
    }
  end

  private
  def value(val)
    val == 0 ? "% 10s" : "% 10.2f"
  end

  def blank(val)
    val == 0 ? "" : val
  end

  def generate_statement
    statement = []
    puts "date       || credit || debit   || balance"
    @transactions.each_with_index do |trans, index|
      date = trans.date
      if trans.trans_type == "deposit"
        credit = trans.amnt
        debit = 0
      elsif trans.trans_type == "withdrawal"
        debit = trans.amnt
        credit = 0
      end
      balance = balance(index+1)
      statement << [date,credit,debit,balance]
    end
    statement
  end
end

acc = Account.new("A Person")
acc.add_trans(Deposit.new(32.21))
dep1 = Deposit.new(25.38)
acc.add_trans(dep1)
puts acc.balance
wdraw1 = Withdrawal.new(100, "31/2/2016")
acc.add_trans(wdraw1)
puts wdraw1.amnt
puts acc.balance
puts acc.balance(3)
acc.statement("rev")
