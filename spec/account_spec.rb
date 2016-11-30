require 'account'

describe Account do

  let(:deposit_1) {double(:deposit, amnt: 50.01, trans_type: "deposit", date: "28/11/2016")}
  let(:withdrawal_1) {double(:withdrawal, amnt: 75.66, trans_type: "withdrawal", date: "30/11/2016")}

  context 'Add transactions' do
    before do
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
    "date        || credit||  debit|| balance\n30/11/2016  ||       ||  75.66||  -25.65\n28/11/2016  ||  50.01||       ||   50.01\n"
    ).to_stdout }

    let(:deposit_2) {double(:deposit, amnt: 50.01, trans_type: "refund", date: "28/11/2016")}
    it 'rejects a non-permitted transaction type' do
      expect{subject.add_trans(deposit_2)}.to raise_error(RuntimeError, "Invalid transaction type") 
    end

  end

  end
