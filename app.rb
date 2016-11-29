class Transaction
  require 'date'

  attr_reader :amnt, :trans_type, :date

  def initialize(trans_type, amnt, date=Time.now.strftime("%d/%m/%Y"))
    @trans_type = trans_type
    @amnt = amnt
    validate_date(date)
    @date = date
  end

  def validate_date(date)
    begin
      date = Date.strptime(date, "%d/%m/%Y")
    rescue ArgumentError
      puts "==> Sorry, the date \"#{date}\" is invalid <=="
      exit
    end
    if date.year > Time.now().year
     puts "==> Sorry, this date \"#{date.strftime("%d/%m/%Y")}\" is in the future and is invalid <=="
     exit
    end
    date = date.strftime("%d/%m/%Y")
    date
  end
end

class Deposit < Transaction
  def initialize(amnt, date=Time.now.strftime("%d/%m/%Y"))
    @trans_type = "deposit"
    @amnt = amnt
    @date = validate_date(date)
  end
end

class Withdrawal < Transaction
  def initialize(amnt, date=Time.now.strftime("%d/%m/%Y"))
    @trans_type = "withdrawal"
    @amnt = amnt
    @date = validate_date(date)
  end
end

class Account
  def initialize(name = "")
    @name = name
    @balance = 0;
    @transactions = []
    @allowed_trans = ["deposit","withdrawal"]
  end

  def add_trans(*trans)
    trans.each do |t|
      valid_trans_type(t) ? @transactions << t : (raise "Invalid transaction type")
    end
  end

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
    cols = column_widths(statement_lines)
    print cols; puts
    printf("%-#{cols[0]+2}s||%#{cols[1]+2}s||%#{cols[2]+2}s||%#{cols[3]+2}s\n", "date", "credit", "debit", "balance")
    statement_lines.each{|t|
      date = t[0];credit=t[1];debit=t[2];bal=t[3]
      printf("%-#{cols[0]+2}s||#{value(credit,cols[1]+2)}||#{value(debit,cols[2]+2)}||#{value(bal,cols[3]+2)}\n", date, blank(credit), blank(debit), bal)
    }
  end

  private
    def valid_trans_type(trans)
      @allowed_trans.include? trans.trans_type
    end

    def generate_statement
    statement = []
    @transactions.each_with_index do |trans, index|
      date = trans.date
      if trans.trans_type == "deposit"
        credit = (trans.amnt).round(2)
        debit = 0
      elsif trans.trans_type == "withdrawal"
        debit = (trans.amnt).round(2)
        credit = 0
      end
      balance = balance(index+1).round(2)
      statement << [date,credit,debit,balance]
    end
    statement
  end

  def value(val,col)
    val == 0 ? "% #{col}s" : "% #{col}.2f"
  end

  def blank(val)
    val == 0 ? "" : val
  end

  def column_widths(stat_lines)
    line_width = []
    item1 = 0; item2 = 0; item3 = 0; item4 = 0
    stat_lines.each{|l|
      item1 < l[0].to_s.length ? item1 = l[0].to_s.length : item1
      item2 < l[1].to_s.length ? item2 = l[1].to_s.length : item1
      item3 < l[2].to_s.length ? item3 = l[2].to_s.length : item1
      item4 < l[3].to_s.length ? item4 = l[3].to_s.length : item1
    }
    return line_width.push(item1, item2, item3, item4)
  end
end

acc = Account.new("A Person")
acc.add_trans(Deposit.new(40, "2/3/2016"))
acc.add_trans(Deposit.new(62.2, "31/3/2016"))
dep1 = Deposit.new(920)
acc.add_trans(dep1)
puts acc.balance
wdraw2 = Withdrawal.new(104450.1, "8/6/2016")
wdraw1 = Withdrawal.new(220, "5/9/2016")
acc.add_trans(wdraw1, wdraw2)
puts wdraw1.amnt
puts acc.balance
puts acc.balance(3)
acc.statement
