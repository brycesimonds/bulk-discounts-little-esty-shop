class BulkDiscount < ApplicationRecord
    validates :percent_discount, numericality: { only_integer: true }
    validates :quantity_threshold, numericality: { only_integer: true }
  
    # has_many :invoices
    # has_many :invoice_items, through: :invoices
    # has_many :items, through: :invoice_items
    # has_many :merchants, through: :items
  end