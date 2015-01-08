require 'rails_helper'

RSpec.describe Company, :type => :model do
  let(:company) { Company.create(name: 'Rainbow Socks Co.')}

  it 'is valid' do
    expect(company).to be_valid
  end

  it 'requires a name to be valid' do
    company = Company.new
    expect(company).to_not be_valid
  end

  it 'has an array of phone numbers' do
    phone_number = company.phone_numbers.build(number: '333-4444')
    expect(phone_number.number).to eq('333-4444')
  end
end
