require 'rails_helper'

describe 'the company view', type: :feature do

  let(:company) { Company.create(name: 'Pickle Company') }

  describe 'phone_numbers' do

    before(:each) do
      company.phone_numbers.create(number: "555-1234")
      company.phone_numbers.create(number: "555-5678")
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
      page.fill_in('Number', with: '555-8888')
      page.click_button('Create Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-8888')
    end

    it 'has links to edit phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end

    it 'edits a phone number' do
      phone = company.phone_numbers.first
      old_number = phone.number

      first(:link, 'edit').click
      page.fill_in('Number', with: '555-9191')
      page.click_button('Update Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-9191')
      expect(page).to_not have_content(old_number)
    end

    it 'has links to delete phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone))
      end
    end

    it 'deletes a phone number' do
      phone = company.phone_numbers.first

      expect(page).to have_content('555-1234')
      first(:link, 'delete').click
      expect(current_path).to eq(company_path(company))
      expect(page).to_not have_content('555-1234')
    end
  end

  describe 'email_addresses' do

    before(:each) do
      company.email_addresses.create(address: "pickelsrus@pickle.com")
      company.email_addresses.create(address: "marketing@pickle.com")
      visit company_path(company)
    end

    it 'lists each email address' do
      expect(page).to have_selector('li', text: 'pickelsrus@pickle.com')
    end

    it 'has an add email address link' do
      page.click_link('Add email address')
      expect(current_path).to eq(new_email_address_path)
      page.fill_in('Address', with: 'kosher@pickle.com')
      page.click_button('Create Email address')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('kosher@pickle.com')
    end

    it 'has links to edit email addresses' do
      company.email_addresses.each do |email|
        expect(page).to have_link('edit', href: edit_email_address_path(email))
      end
    end

    it 'edits an email address' do
      email = company.email_addresses.first
      old_email = email.address

      within(".emails_list") do
        first(:link, 'edit').click
      end
      page.fill_in('Address', with: 'butterchip@pickle.com')
      page.click_button('Update Email address')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('butterchip@pickle.com')
      expect(page).to_not have_content(old_email)
    end

    it 'has links to delete an email address' do
      company.email_addresses.each do |email|
        expect(page).to have_link('delete', href: email_address_path(email))
      end
    end

    it 'deletes an email address' do
      email = company.email_addresses.first

      within(".emails_list") do
        first(:link, 'delete').click
      end
      expect(current_path).to eq(company_path(company))
      expect(page).to_not have_content(email)
    end
  end
end
