class Withdrawal < Transaction
  def initialize(amnt, date=Time.now.strftime("%d/%m/%Y"))
    @trans_type = "withdrawal"
    @amnt = amnt
    @date = validate_date(date)
  end
end
