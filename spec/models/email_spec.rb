require 'rails_helper'

RSpec.describe Person, :type => :model do
  let(:person) do
    Person.new(first_name: 'Alice', last_name: 'Smith', email: 'asmith@gmail.com')
  end

it 'has an array of emails' do
  expect(person.emails).to eq([])
end
