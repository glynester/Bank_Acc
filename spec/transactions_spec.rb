require ''

describe Transaction do

  describe '#initialize' do

    it 'has a default entry_station of nil' do
      expect(subject.entry_station).to eq nil
    end
  end

end
