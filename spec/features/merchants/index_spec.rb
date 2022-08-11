require 'rails_helper'
require 'faker'

RSpec.describe "merchants index page" do
  describe '#index' do
    it 'shows all merchants' do
      merchant_1 = Merchant.create!(name: Faker::Name.name)
      merchant_2 = Merchant.create!(name: Faker::Name.name)
      merchant_3 = Merchant.create!(name: Faker::Name.name)
      merchant_4 = Merchant.create!(name: Faker::Name.name)
      
      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 500, merchant_id: merchant_1.id )
      item_2 = Item.create!(name: "Saw", description: "Metal, sharp", unit_price: 700, merchant_id: merchant_1.id )
      item_3 = Item.create!(name: "Bench", description: "Cedar bench", unit_price: 900, merchant_id: merchant_1.id )

      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")

      invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)
      invoice_2 = Invoice.create!(status: 0, customer_id: customer_1.id)
      invoice_3 = Invoice.create!(status: 0, customer_id: customer_1.id)

      invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 800, status: 0, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 1400, status: 0, item_id: item_2.id, invoice_id: invoice_2.id)
      invoice_item_3 = InvoiceItem.create!(quantity: 3, unit_price: 666, status: 0, item_id: item_3.id, invoice_id: invoice_3.id)

      visit "/merchants"
    
      expect(page).to have_content("#{merchant_1.name}")
      expect(page).to have_content("#{merchant_2.name}")
      expect(page).to have_content("#{merchant_3.name}")
      expect(page).to have_content("#{merchant_4.name}")
    end
  end
end 