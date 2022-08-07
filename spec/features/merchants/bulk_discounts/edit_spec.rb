require 'rails_helper'
require 'faker'

RSpec.describe 'Bulk Discounts Edit Page' do
    it 'has a pre filled form with current attributes of the discount' do
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
        invoice_3 = Invoice.create!(status: 1, created_at: Time.new(2002), customer_id: customer_3.id)
        invoice_4 = Invoice.create!(status: 2, created_at: Time.new(2003), customer_id: customer_4.id)

        invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 800, status: 1, item_id: item_1.id, invoice_id: invoice_1.id)
        invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 1400, status: 1, item_id: item_2.id, invoice_id: invoice_1.id)
        invoice_item_3 = InvoiceItem.create!(quantity: 3, unit_price: 666, status: 2, item_id: item_3.id, invoice_id: invoice_1.id)
        invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 1400, status: 1, item_id: item_4.id, invoice_id: invoice_2.id)
        invoice_item_5 = InvoiceItem.create!(quantity: 3, unit_price: 666, status: 2, item_id: item_5.id, invoice_id: invoice_3.id)
        invoice_item_6 = InvoiceItem.create!(quantity: 3, unit_price: 666, status: 2, item_id: item_5.id, invoice_id: invoice_3.id)

        bulk_discount_1 = BulkDiscount.create!(percent_discount: 20, quantity_threshold: 10, merchant_id: merchant_1.id)

        visit "/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_discount_1.id}/edit"


        expect(find('form')).to have_content('Percent discount')
        expect(find('form')).to have_content('20')
        expect(find('form')).to have_content('Quantity threshold')
        expect(find('form')).to have_content('10')
        expect(find('form')).to_not have_content('Merchant id')
    end
end 