require 'account'
require 'deposit'      #If I was doubling properly I wouldn't need this!
require 'withdrawal'   #If I was doubling properly I wouldn't need this!

describe Account do

  # let(:deposit_1) {double(:deposit)}
  # let(:withdrawal_1) {double(:withdrawal)}
  deposit_1 = Deposit.new(50.01)
  withdrawal_1 = Withdrawal.new(75.66)

  context 'Add transactions' do
    before do
      # subject.add_trans(:deposit_1, amnt: 50.01, trans_type: "deposit")
      # subject.add_trans(:withdrawal_1, amnt: 75.66, trans_type: "withdrawal")
      subject.add_trans(deposit_1)
      subject.add_trans(withdrawal_1)
    end

    it 'shows correct balance' do
      expect(subject.balance).to eq -25.65
    end

    # date        || credit||  debit|| balance
    # 30/11/2016  ||       ||  75.66||  -25.65
    # 30/11/2016  ||  50.01||       ||   50.01

    specify { expect { subject.statement }.to output(
    "date        || credit||  debit|| balance\n30/11/2016  ||       ||  75.66||  -25.65\n30/11/2016  ||  50.01||       ||   50.01\n"
    ).to_stdout }

  end

  end
