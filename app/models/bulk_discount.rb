class BulkDiscount < ApplicationRecord
    validates_presence_of :percent_discount
    validates_presence_of :quantity_threshold
  
    # has_many :invoices
    # has_many :invoice_items, through: :invoices
    # has_many :items, through: :invoice_items
    # has_many :merchants, through: :items
  end