require 'account'
require 'deposit'      #If I was doubling properly I wouldn't need this!
require 'withdrawal'   #If I was doubling properly I wouldn't need this!

describe Account do

  # let(:deposit_1) {double(:deposit)}
  # let(:withdrawal_1) {double(:withdrawal)}
  deposit_1 = Deposit.new(50.01)
  withdrawal_1 = Withdrawal.new(75.66)

  context 'With max balance on card' do
    before do
      # subject.add_trans(:deposit_1, amnt: 50.01, trans_type: "deposit")
      # subject.add_trans(:withdrawal_1, amnt: 75.66, trans_type: "withdrawal")
      subject.add_trans(deposit_1)
      subject.add_trans(withdrawal_1)
    end

    it 'shows correct balance' do
      expect(subject.balance).to eq -25.65
    end
  end

  end
