require 'rails_helper'

describe 'the person view', type: :feature do
  let(:person) { Person.create(first_name: "Bob", last_name: "Smith") }

  describe 'phone numbers' do
    before(:each) do
      person.phone_numbers.create(number: "804-380-0357")
      person.phone_numbers.create(number: "804-380-0258")
      visit person_path(person)
    end

    it 'shows the phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it 'has a link to add a new phone number' do
      expect(page).to have_link('Add phone number', href: new_phone_number_path(contact_id: person.id, contact_type: 'Person'))
    end

    it 'adds a new phone number' do
      page.click_link('Add phone number')
      page.fill_in('Number', with: '555-5555')
      page.click_button('Create Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-5555')
    end

    it 'has links to edit phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('edit', edit_phone_number_path(phone))
      end
    end

    it 'edits a phone number' do
      phone = person.phone_numbers.first
      old_number = phone.number

      first(:link, 'edit').click
      page.fill_in('Number', with: '555-5555')
      page.click_button('Update Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-5555')
      expect(page).to_not have_content(old_number)
    end

    it 'has links to delete phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone, contact_id: person.id, contact_type: 'Person'))
      end
    end

    it 'deletes a phone number' do
      first(:link, 'delete').click
      expect(current_path).to eq(person_path(person))
      expect(page).to_not have_content('804-380-0357')
      first(:link, 'delete').click
      expect(page).to_not have_content('804-380-0357')
      expect(page).to_not have_link('delete')
    end
  end

  describe 'email addresses' do
    before(:each) do
      person.email_addresses.create(address: 'bob@gmail.com')
      person.email_addresses.create(address: 'bobs@gmail.com')
      visit person_path(person)
    end

    it 'shows the email addresses' do
      person.email_addresses.each do |email|
        expect(page).to have_selector('li', text: email.address)
      end
    end

    it 'has link to add email address' do
      expect(page).to have_link('Add email address', href: new_email_address_path(contact_id: person.id, contact_type: 'Person'))
    end

    it 'adds a email address' do
      click_link('Add email address')
      page.fill_in('Address', with: 'bob@example.com')
      click_button('Create Email address')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('bob@example.com')
    end

    it 'has links to edit email addresses' do
      person.email_addresses.each do |email|
        expect(page).to have_link('edit', edit_email_address_path(email))
      end
    end

    it 'edits a email address' do
      email = person.email_addresses.first
      old_email = email.address

      first(:link, "edit").click
      fill_in('Address', with: 'bob@yahoo.com')
      page.click_button('Update Email address')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('bobs@yahoo.com')
      expect(page).to_not have_content(old_email)
    end

    it 'has links to delete an email address' do
      person.email_addresses.each do |email|
        expect(page).to have_link('delete', href: email_address_path(email, contact_id: person.id, contact_type: 'Person' ))
      end
    end

    it 'deletes a email address' do
      first(:link, 'delete').click
      expect(current_path).to eq(person_path(person))
      expect(page).to_not have_content('bob@gmail.com')
      first(:link, 'delete').click
      expect(page).to_not have_content('bobs@gmail.com')
      expect(page).to_not have_link('delete')
    end
  end
end
