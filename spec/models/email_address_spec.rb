require 'rails_helper'

RSpec.describe EmailAddress, type: :model do
  let(:email_address) { EmailAddress.new(address: "jillmd501@gmail.com", person_id: 1) }
  it 'is valid' do
    expect(email_address).to be_valid
  end

  it 'is invalid without an email address' do
    person.email_address = nil
    expect(person).to_not be_valid
  end

  it 'is associated with a person' do
    expect(email_address).to respond_to(:person)
  end
end
