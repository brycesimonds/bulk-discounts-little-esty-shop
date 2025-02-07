require 'rails_helper'

RSpec.describe Invoice do
  describe 'validations' do
    it { should validate_presence_of(:status) }
  end

  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:bulk_discounts).through(:merchants) }
  end

  describe 'model methods' do
    it "#total_revenue" do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      merchant_2 = Merchant.create!(name: "Roberts Loggings")
      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 200, merchant_id: merchant_1.id )
      item_2 = Item.create!(name: "Saw", description: "Metal, sharp", unit_price: 300, merchant_id: merchant_1.id )
      item_3 = Item.create!(name: "Bench", description: "Cedar bench", unit_price: 400, merchant_id: merchant_1.id )
      item_4 = Item.create!(name: "Axe", description: "Big Axe", unit_price: 500, merchant_id: merchant_1.id )
      item_5 = Item.create!(name: "Hammer", description: "Carpenter's hammer, wood handle", unit_price: 600, merchant_id: merchant_2.id )
      item_6 = Item.create!(name: "Speed Square", description: "Metal w/ level", unit_price: 700, merchant_id: merchant_2.id )
      item_7 = Item.create!(name: "Mallet", description: "Wooden carpenter's mallet", unit_price: 800, merchant_id: merchant_2.id )
      item_8 = Item.create!(name: "Reciprocating Saw", description: "Electric reciprocating saw", unit_price: 900, merchant_id: merchant_2.id )

      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")
      customer_2 = Customer.create!(first_name: "Cindy", last_name: "Lou")
      customer_3 = Customer.create!(first_name: "John", last_name: "Johnson")
      customer_4 = Customer.create!(first_name: "Mary", last_name: "Vale")

      invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)
      invoice_2 = Invoice.create!(status: 0, customer_id: customer_2.id)
      invoice_3 = Invoice.create!(status: 2, customer_id: customer_3.id)
      invoice_4 = Invoice.create!(status: 2, customer_id: customer_4.id)
      invoice_5 = Invoice.create!(status: 0, customer_id: customer_4.id)

      invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 200, status: 0, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 300, status: 1, item_id: item_2.id, invoice_id: invoice_1.id)
      invoice_item_3 = InvoiceItem.create!(quantity: 3, unit_price: 400, status: 2, item_id: item_3.id, invoice_id: invoice_2.id)
      invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 500, status: 1, item_id: item_4.id, invoice_id: invoice_2.id)
      invoice_item_5 = InvoiceItem.create!(quantity: 3, unit_price: 600, status: 2, item_id: item_5.id, invoice_id: invoice_3.id)
      invoice_item_6 = InvoiceItem.create!(quantity: 3, unit_price: 700, status: 0, item_id: item_6.id, invoice_id: invoice_3.id)
      invoice_item_7 = InvoiceItem.create!(quantity: 3, unit_price: 800, status: 2, item_id: item_7.id, invoice_id: invoice_4.id)
      invoice_item_8 = InvoiceItem.create!(quantity: 3, unit_price: 900, status: 2, item_id: item_8.id, invoice_id: invoice_4.id)
      invoice_item_9 = InvoiceItem.create!(quantity: 3, unit_price: 900, status: 1, item_id: item_8.id, invoice_id: invoice_5.id)
      invoice_item_10 = InvoiceItem.create!(quantity: 3, unit_price: 900, status: 1, item_id: item_8.id, invoice_id: invoice_5.id)

      expect(invoice_1.total_revenue).to eq(1400)
      expect(invoice_2.total_revenue).to eq(2200)
    end

    it '.discounted revenue' do
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
  
      invoice_item_5 = InvoiceItem.create!(quantity: 11, unit_price: 100, status: 2, item_id: item_2.id, invoice_id: invoice_3.id)
      invoice_item_6 = InvoiceItem.create!(quantity: 1, unit_price: 1000, status: 2, item_id: item_5.id, invoice_id: invoice_3.id)
  
      bulk_discount_1 = BulkDiscount.create!(percent_discount: 10, quantity_threshold: 10, merchant_id: merchant_1.id)
      bulk_discount_2 = BulkDiscount.create!(percent_discount: 20, quantity_threshold: 11, merchant_id: merchant_1.id)
      
      expect(invoice_3.discounted_revenue).to eq(1880)
    end 

    it "#incomplete_invoices" do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      merchant_2 = Merchant.create!(name: "Roberts Loggings")
      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 200, merchant_id: merchant_1.id )
      item_2 = Item.create!(name: "Saw", description: "Metal, sharp", unit_price: 300, merchant_id: merchant_1.id )
      item_3 = Item.create!(name: "Bench", description: "Cedar bench", unit_price: 400, merchant_id: merchant_1.id )
      item_4 = Item.create!(name: "Axe", description: "Big Axe", unit_price: 500, merchant_id: merchant_1.id )
      item_5 = Item.create!(name: "Hammer", description: "Carpenter's hammer, wood handle", unit_price: 600, merchant_id: merchant_2.id )
      item_6 = Item.create!(name: "Speed Square", description: "Metal w/ level", unit_price: 700, merchant_id: merchant_2.id )
      item_7 = Item.create!(name: "Mallet", description: "Wooden carpenter's mallet", unit_price: 800, merchant_id: merchant_2.id )
      item_8 = Item.create!(name: "Reciprocating Saw", description: "Electric reciprocating saw", unit_price: 900, merchant_id: merchant_2.id )

      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")
      customer_2 = Customer.create!(first_name: "Cindy", last_name: "Lou")
      customer_3 = Customer.create!(first_name: "John", last_name: "Johnson")
      customer_4 = Customer.create!(first_name: "Mary", last_name: "Vale")

      invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)
      invoice_2 = Invoice.create!(status: 0, customer_id: customer_2.id)
      invoice_3 = Invoice.create!(status: 2, customer_id: customer_3.id)
      invoice_4 = Invoice.create!(status: 2, customer_id: customer_4.id)
      invoice_5 = Invoice.create!(status: 0, customer_id: customer_4.id)

      invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 200, status: 0, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 300, status: 1, item_id: item_2.id, invoice_id: invoice_1.id)
      invoice_item_3 = InvoiceItem.create!(quantity: 3, unit_price: 400, status: 2, item_id: item_3.id, invoice_id: invoice_2.id)
      invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 500, status: 1, item_id: item_4.id, invoice_id: invoice_2.id)
      invoice_item_5 = InvoiceItem.create!(quantity: 3, unit_price: 600, status: 2, item_id: item_5.id, invoice_id: invoice_3.id)
      invoice_item_6 = InvoiceItem.create!(quantity: 3, unit_price: 700, status: 0, item_id: item_6.id, invoice_id: invoice_3.id)
      invoice_item_7 = InvoiceItem.create!(quantity: 3, unit_price: 800, status: 2, item_id: item_7.id, invoice_id: invoice_4.id)
      invoice_item_8 = InvoiceItem.create!(quantity: 3, unit_price: 900, status: 2, item_id: item_8.id, invoice_id: invoice_4.id)
      invoice_item_9 = InvoiceItem.create!(quantity: 3, unit_price: 900, status: 1, item_id: item_8.id, invoice_id: invoice_5.id)
      invoice_item_10 = InvoiceItem.create!(quantity: 3, unit_price: 900, status: 1, item_id: item_8.id, invoice_id: invoice_5.id)

      expect(Invoice.incomplete_invoices.count).to eq(4)
      expect(Invoice.incomplete_invoices).to eq([invoice_1, invoice_2, invoice_3, invoice_5])
    end
  end

  describe 'the given examples to test discounted revenue against' do
    it '.discounted revenue - example 1' do
      merchant_1 = Merchant.create!(name: Faker::Name.name)
  
      item_1 = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 500, merchant_id: merchant_1.id )
      item_2 = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 500, merchant_id: merchant_1.id )
  
      customer_1 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
  
      invoice_1 = Invoice.create!(status: 0, created_at: Time.new(2000), customer_id: customer_1.id)
  
      invoice_item_1 = InvoiceItem.create!(quantity: 5, unit_price: 100, status: 2, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 5, unit_price: 1000, status: 2, item_id: item_2.id, invoice_id: invoice_1.id)
  
      bulk_discount_1 = BulkDiscount.create!(percent_discount: 20, quantity_threshold: 10, merchant_id: merchant_1.id)
      
      expect(invoice_1.discounted_revenue).to eq(nil)
    end 

    it '.discounted revenue - example 2' do
      merchant_1 = Merchant.create!(name: Faker::Name.name)
  
      item_1 = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 500, merchant_id: merchant_1.id )
      item_2 = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 500, merchant_id: merchant_1.id )
  
      customer_1 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
  
      invoice_1 = Invoice.create!(status: 0, created_at: Time.new(2000), customer_id: customer_1.id)
  
      invoice_item_1 = InvoiceItem.create!(quantity: 10, unit_price: 100, status: 2, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 5, unit_price: 1000, status: 2, item_id: item_2.id, invoice_id: invoice_1.id)
  
      bulk_discount_1 = BulkDiscount.create!(percent_discount: 20, quantity_threshold: 10, merchant_id: merchant_1.id)
      
      expect(invoice_1.discounted_revenue).to eq(5800)
    end 

    it '.discounted revenue - example 3' do
      merchant_1 = Merchant.create!(name: Faker::Name.name)
  
      item_1 = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 500, merchant_id: merchant_1.id )
      item_2 = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 500, merchant_id: merchant_1.id )
  
      customer_1 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
  
      invoice_1 = Invoice.create!(status: 0, created_at: Time.new(2000), customer_id: customer_1.id)
  
      invoice_item_1 = InvoiceItem.create!(quantity: 12, unit_price: 10, status: 2, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 15, unit_price: 100, status: 2, item_id: item_2.id, invoice_id: invoice_1.id)
  
      bulk_discount_1 = BulkDiscount.create!(percent_discount: 20, quantity_threshold: 10, merchant_id: merchant_1.id)
      bulk_discount_2 = BulkDiscount.create!(percent_discount: 30, quantity_threshold: 15, merchant_id: merchant_1.id)
      
      expect(invoice_1.discounted_revenue).to eq(1146)
    end 

    it '.discounted revenue - example 4' do
      merchant_1 = Merchant.create!(name: Faker::Name.name)
  
      item_1 = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 500, merchant_id: merchant_1.id )
      item_2 = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 500, merchant_id: merchant_1.id )
  
      customer_1 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
  
      invoice_1 = Invoice.create!(status: 0, created_at: Time.new(2000), customer_id: customer_1.id)
  
      invoice_item_1 = InvoiceItem.create!(quantity: 12, unit_price: 10, status: 2, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 15, unit_price: 100, status: 2, item_id: item_2.id, invoice_id: invoice_1.id)
  
      bulk_discount_1 = BulkDiscount.create!(percent_discount: 20, quantity_threshold: 10, merchant_id: merchant_1.id)
      bulk_discount_2 = BulkDiscount.create!(percent_discount: 15, quantity_threshold: 15, merchant_id: merchant_1.id)
      
      expect(invoice_1.discounted_revenue).to eq(1296)
    end 

    it '.discounted revenue - example 5' do
      merchant_A = Merchant.create!(name: Faker::Name.name)
      merchant_no_discounts = Merchant.create!(name: Faker::Name.name)
  
      item_A1 = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 500, merchant_id: merchant_A.id )
      item_A2 = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 500, merchant_id: merchant_A.id )
      item_merchant_no_discounts = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 500, merchant_id: merchant_no_discounts.id )
  
      customer_1 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
  
      invoice_A = Invoice.create!(status: 0, created_at: Time.new(2000), customer_id: customer_1.id)
  
      invoice_item_A1 = InvoiceItem.create!(quantity: 12, unit_price: 10, status: 2, item_id: item_A1.id, invoice_id: invoice_A.id)
      invoice_item_A2 = InvoiceItem.create!(quantity: 15, unit_price: 100, status: 2, item_id: item_A2.id, invoice_id: invoice_A.id)
      invoice_item_A3 = InvoiceItem.create!(quantity: 15, unit_price: 100, status: 2, item_id: item_merchant_no_discounts.id, invoice_id: invoice_A.id)
  
      bulk_discount_A = BulkDiscount.create!(percent_discount: 20, quantity_threshold: 10, merchant_id: merchant_A.id)
      bulk_discount_B = BulkDiscount.create!(percent_discount: 30, quantity_threshold: 15, merchant_id: merchant_A.id)
      
      expect(invoice_A.discounted_revenue).to eq(2646)
    end 
  end
end
