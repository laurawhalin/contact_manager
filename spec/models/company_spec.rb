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

end
