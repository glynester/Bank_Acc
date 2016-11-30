require 'account'

describe Deposit do

    context 'generate a new transaction' do

    subject {described_class.new(220, "5/9/2016")}

    it 'has the expected value' do
      expect(subject.amnt).to eq 220
    end
  end

end

describe Withdrawal do

    context 'generate a new transaction' do

    subject {described_class.new(220, "5/9/2016")}

    it 'has the expected value' do
      expect(subject.date).to eq "05/09/2016"
    end
  end

end
