class BulkDiscount < ApplicationRecord
    validates :percent_discount, numericality: { less_than_or_equal_to: 100, only_integer: true }
    validates :quantity_threshold, numericality: { greater_than: 0, only_integer: true }

    belongs_to :merchant
    has_many :items, through: :merchant 
    has_many :invoice_items, through: :items
  end