require 'rails_helper'
require 'faker'

RSpec.describe 'Bulk Discounts Index Page' do
    it 'lists all the merchants discounts as links' do
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
        bulk_discount_2 = BulkDiscount.create!(percent_discount: 10, quantity_threshold: 5, merchant_id: merchant_1.id)
        bulk_discount_3 = BulkDiscount.create!(percent_discount: 5, quantity_threshold: 2, merchant_id: merchant_1.id)
        bulk_discount_4 = BulkDiscount.create!(percent_discount: 50, quantity_threshold: 70, merchant_id: merchant_1.id)
        bulk_discount_5 = BulkDiscount.create!(percent_discount: 30, quantity_threshold: 20, merchant_id: merchant_1.id)

        visit "/merchants/#{merchant_1.id}/bulk_discounts"

        within "#discount-#{bulk_discount_1.id}" do
            expect(page).to have_link("This discount is 20% off 10 items")
        end
        within "#discount-#{bulk_discount_2.id}" do
            expect(page).to have_link("This discount is 10% off 5 items")
        end
        within "#discount-#{bulk_discount_3.id}" do
            expect(page).to have_link("This discount is 5% off 2 items")
        end
        within "#discount-#{bulk_discount_4.id}" do
            expect(page).to have_link("This discount is 50% off 70 items")
        end
        within "#discount-#{bulk_discount_5.id}" do
            expect(page).to have_link("This discount is 30% off 20 items")
        end
    end
    
    it 'the link brings you to that discounts show page' do
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
        bulk_discount_2 = BulkDiscount.create!(percent_discount: 10, quantity_threshold: 5, merchant_id: merchant_1.id)
        bulk_discount_3 = BulkDiscount.create!(percent_discount: 5, quantity_threshold: 2, merchant_id: merchant_1.id)
        bulk_discount_4 = BulkDiscount.create!(percent_discount: 50, quantity_threshold: 70, merchant_id: merchant_1.id)
        bulk_discount_5 = BulkDiscount.create!(percent_discount: 30, quantity_threshold: 20, merchant_id: merchant_1.id)

        visit "/merchants/#{merchant_1.id}/bulk_discounts"
    
        within "#discount-#{bulk_discount_1.id}" do
            click_on "This discount is 20% off 10 items"
        end
        expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_discount_1.id}")
    end
    
    it 'has a link that brings you to a create discount page' do
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
        bulk_discount_2 = BulkDiscount.create!(percent_discount: 10, quantity_threshold: 5, merchant_id: merchant_1.id)
        bulk_discount_3 = BulkDiscount.create!(percent_discount: 5, quantity_threshold: 2, merchant_id: merchant_1.id)
        bulk_discount_4 = BulkDiscount.create!(percent_discount: 50, quantity_threshold: 70, merchant_id: merchant_1.id)
        bulk_discount_5 = BulkDiscount.create!(percent_discount: 30, quantity_threshold: 20, merchant_id: merchant_1.id)

        visit "/merchants/#{merchant_1.id}/bulk_discounts"
    
        within "#nav" do
            click_on "Create New Bulk Discount"
        end
        expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/new")
    end

    it 'has a link next to each bulk discount to delete it' do
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
        bulk_discount_2 = BulkDiscount.create!(percent_discount: 10, quantity_threshold: 5, merchant_id: merchant_1.id)
        bulk_discount_3 = BulkDiscount.create!(percent_discount: 5, quantity_threshold: 2, merchant_id: merchant_1.id)
        bulk_discount_4 = BulkDiscount.create!(percent_discount: 50, quantity_threshold: 70, merchant_id: merchant_1.id)
        bulk_discount_5 = BulkDiscount.create!(percent_discount: 30, quantity_threshold: 20, merchant_id: merchant_1.id)

        visit "/merchants/#{merchant_1.id}/bulk_discounts"
        
        within "#discount-#{bulk_discount_1.id}" do
            expect(page).to have_button("Delete This Bulk Discount")
        end
        within "#discount-#{bulk_discount_2.id}" do
            expect(page).to have_button("Delete This Bulk Discount")
        end
        within "#discount-#{bulk_discount_3.id}" do
            expect(page).to have_button("Delete This Bulk Discount")
        end
        within "#discount-#{bulk_discount_4.id}" do
            expect(page).to have_button("Delete This Bulk Discount")
        end
        within "#discount-#{bulk_discount_5.id}" do
            expect(page).to have_button("Delete This Bulk Discount")
        end
    end

    it 'when clicked the delete button redirects back to bulk discounts index page and has deleted the record' do
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
        bulk_discount_2 = BulkDiscount.create!(percent_discount: 10, quantity_threshold: 5, merchant_id: merchant_1.id)
        bulk_discount_3 = BulkDiscount.create!(percent_discount: 5, quantity_threshold: 2, merchant_id: merchant_1.id)
        bulk_discount_4 = BulkDiscount.create!(percent_discount: 50, quantity_threshold: 70, merchant_id: merchant_1.id)
        bulk_discount_5 = BulkDiscount.create!(percent_discount: 30, quantity_threshold: 20, merchant_id: merchant_1.id)

        visit "/merchants/#{merchant_1.id}/bulk_discounts"
        
        within "#discount-#{bulk_discount_1.id}" do
            click_on("Delete This Bulk Discount")
        end
        expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts")
        expect(page).to_not have_content("This discount is 20% off 10 items")
        expect(page).to have_content("This discount is 10% off 5 items")
    end
end 