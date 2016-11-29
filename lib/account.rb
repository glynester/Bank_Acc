require_relative 'transaction'
require_relative 'deposit'
require_relative 'withdrawal'

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
      @balance.round(2)
  end

  def statement(order = "down")
    if order == "down"
      statement_lines = generate_statement.reverse
    elsif order == "rev"
      statement_lines = generate_statement
    end
    cols = column_widths(statement_lines)
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
