describe 'the company view', type: :feature do

  let(:company) { Company.create(name: "Yahoo") }

  describe 'phone numbers' do
    before(:each) do
      company.phone_numbers.create(number: "804-380-0357")
      company.phone_numbers.create(number: "804-380-0258")
      visit company_path(company)
    end

    it 'shows the phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it 'has a link to add a new phone number' do
      expect(page).to have_link('Add phone number', href: new_phone_number_path(contact_id: company.id, contact_type: 'Company'))
    end

    it 'adds a new phone number' do
      page.click_link('Add phone number')
      page.fill_in('Number', with: '555-5555')
      page.click_button('Create Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-5555')
    end

    it 'has links to edit phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('edit', edit_phone_number_path(phone))
      end
    end

    it 'edits a phone number' do
      phone = company.phone_numbers.first
      old_number = phone.number

      first(:link, 'edit').click
      page.fill_in('Number', with: '555-5555')
      page.click_button('Update Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-5555')
      expect(page).to_not have_content(old_number)
    end

    it 'has links to delete phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone, contact_id: company.id, contact_type: 'Company'))
      end
    end

    it 'deletes a phone number' do
      first(:link, 'delete').click
      expect(current_path).to eq(company_path(company))
      expect(page).to_not have_content('804-380-0357')
      first(:link, 'delete').click
      expect(page).to_not have_content('804-380-0258')
      expect(page).to_not have_link('delete')
    end
  end

  describe 'email addresses' do
    before(:each) do
      company.email_addresses.create(address: 'alice@google.com')
      company.email_addresses.create(address: 'jill@jill.com')
      visit company_path(company)
    end

    it 'shows the email addresses' do
      company.email_addresses.each do |email|
        expect(page).to have_selector('li', text: email.address)
      end
    end

    it 'has link to add email address' do
      expect(page).to have_link('Add email address', href: new_email_address_path(contact_id: company.id, contact_type: 'Company'))
    end

    it 'adds a email address' do
      click_link('Add email address')
      page.fill_in('Address', with: 'alice@google.com')
      click_button('Create Email address')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('alice@google.com')
    end

    it 'has links to edit email addresses' do
      company.email_addresses.each do |email|
        expect(page).to have_link('edit', edit_email_address_path(email))
      end
    end

    it 'edits a email address' do
      email = company.email_addresses.first
      old_email = email.address

      first(:link, "edit").click
      fill_in('Address', with: 'bob@google.com')
      page.click_button('Update Email address')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('bob@google.com')
      expect(page).to_not have_content(old_email)
    end

    it 'has links to delete an email address' do
      company.email_addresses.each do |email|
        expect(page).to have_link('delete', href: email_address_path(email, contact_id: company.id, contact_type: 'Company'))
      end
    end

    it 'deletes a email address' do
      first(:link, 'delete').click
      expect(current_path).to eq(company_path(company))
      expect(page).to_not have_content('bob@yahoo.com')
      first(:link, 'delete').click
      expect(page).to_not have_content('bob@help.com')
      expect(page).to_not have_link('delete')
    end
  end
end
