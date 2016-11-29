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
