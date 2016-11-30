require 'account'

describe Deposit do
  context 'generate a new transaction' do
    subject {described_class.new(220, "5/9/2016")}
    it 'has the expected value' do
      expect(subject.amnt).to eq 220
    end
  end

  context 'generate a new transaction with an invalid date' do
    subject {described_class.new(220, "35/9/2016")}
    it 'has the expected value' do
      expect(subject.amnt).to output "==> Sorry, the date \"35/9/2016\" is invalid <=="
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
