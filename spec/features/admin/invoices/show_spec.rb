require 'rails_helper'

RSpec.describe 'Admin Invoices Show page' do
  describe 'invoice show reveals info related to invoice' do
    it 'shows an invoices specific info' do
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")

      invoice_1 = Invoice.create!(status: 1, customer_id: customer_1.id)

      visit "/admin/invoices/#{invoice_1.id}"

      created_at = invoice_1.created_at.strftime("%A, %B%e, %Y")

      expect(page).to have_content(invoice_1.id)
      expect(page).to have_content("Status: cancelled")
      expect(page).to have_content("Created at: #{invoice_1.created_at.strftime("%A, %B%e, %Y")}")
      expect(page).to have_content("David Smith")
    end

    it 'shows information + total revenue of all items under an invoice' do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")

      invoice_1 = Invoice.create!(status: 1, customer_id: customer_1.id)

      item_1 = merchant_1.items.create!(name: "Log", description: "Wood, maple", unit_price: 500)
      item_2 = merchant_1.items.create!(name: "Saw", description: "Metal, sharp", unit_price: 700)

      invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 800, status: 0, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 1400, status: 1, item_id: item_2.id, invoice_id: invoice_1.id)

      visit "/admin/invoices/#{invoice_1.id}"

      expect(page).to have_content("Total Revenue: $60.00")

      within "#items-#{item_1.id}" do
        expect(page).to have_content("Item: Log")
        expect(page).to have_content("Quantity: #{invoice_item_1.quantity}")
        expect(page).to have_content("Price: $8.00")
        expect(page).to have_content("Status: pending")
        expect(page).to_not have_content("Status: packaged")
        expect(page).to_not have_content("item: Saw")
      end

      within "#items-#{item_2.id}" do
        expect(page).to have_content("Item: Saw")
        expect(page).to have_content("Quantity: #{invoice_item_2.quantity}")
        expect(page).to have_content("Price: $14.00")
        expect(page).to have_content("Status: packaged")
        expect(page).to_not have_content("Status: pending")
        expect(page).to_not have_content("Item: Log")
      end
    end

    it 'can update an invoices status' do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")

      invoice_1 = Invoice.create!(status: 1, customer_id: customer_1.id)

      item_1 = merchant_1.items.create!(name: "Log", description: "Wood, maple", unit_price: 500)
      item_2 = merchant_1.items.create!(name: "Saw", description: "Metal, sharp", unit_price: 700)

      invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 800, status: 0, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 1400, status: 1, item_id: item_2.id, invoice_id: invoice_1.id)

      visit "/admin/invoices/#{invoice_1.id}"

      within "#items-#{item_1.id}" do
        expect(page).to have_select(:update_status, selected: "pending")
        select 'packaged', :from => :update_status
        click_on "Update Status"
        expect(current_path).to eq("/admin/invoices/#{invoice_1.id}")
        expect(page).to have_select(:update_status, selected: "packaged")
      end

      within "#items-#{item_2.id}" do
        expect(page).to have_select(:update_status, selected: "packaged")
        select 'shipped', :from => :update_status
        click_on "Update Status"
        expect(current_path).to eq("/admin/invoices/#{invoice_1.id}")
        expect(page).to have_select(:update_status, selected: "shipped")
      end
    end

    it 'shows the discounted total revenue for the merchant' do
      merchant_1 = Merchant.create!(name: Faker::Name.name)
  
      item_1 = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 500, merchant_id: merchant_1.id )
      item_2 = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 500, merchant_id: merchant_1.id )
      item_3 = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 500, merchant_id: merchant_1.id )
      item_4 = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 500, merchant_id: merchant_1.id )
      item_5 = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 500, merchant_id: merchant_1.id )
  
      customer_1 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
      customer_2 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
      customer_3 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
      customer_4 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
  
      invoice_1 = Invoice.create!(status: 0, created_at: Time.new(2000), customer_id: customer_1.id)
      invoice_2 = Invoice.create!(status: 1, created_at: Time.new(2001), customer_id: customer_2.id)
      invoice_3 = Invoice.create!(status: 2, created_at: Time.new(2002), customer_id: customer_3.id)
      invoice_4 = Invoice.create!(status: 2, created_at: Time.new(2003), customer_id: customer_4.id)
  
      invoice_item_5 = InvoiceItem.create!(quantity: 10, unit_price: 100, status: 2, item_id: item_2.id, invoice_id: invoice_3.id)
      invoice_item_6 = InvoiceItem.create!(quantity: 1, unit_price: 1000, status: 2, item_id: item_5.id, invoice_id: invoice_3.id)
  
      bulk_discount_1 = BulkDiscount.create!(percent_discount: 10, quantity_threshold: 10, merchant_id: merchant_1.id)

      visit "/admin/invoices/#{invoice_3.id}"
      
      expect(page).to have_content("$19.00")
    end 
  end
end
