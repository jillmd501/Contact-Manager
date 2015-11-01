require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:google) { Company.new(name: "Google") }

  it 'is valid' do
    expect(google).to be_valid
  end

  it 'is invalid without a name' do
    company = Company.new(name: nil)

    expect(company).not_to be_valid
  end

  it 'has an array of phone numbers' do
    expect(google.phone_numbers).to eq([])
  end

  it 'responds to a phone number after its created' do
    phone_number = google.phone_numbers.build(number: '555-4444')
    expect(phone_number.number).to eq('555-4444')
  end

  it 'responds to a email address after its created' do
    email_address = google.email_addresses.build(address: 'bob@gmail.com')
    expect(email_address.address).to eq('bob@gmail.com')
  end


end
