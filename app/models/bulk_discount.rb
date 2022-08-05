class BulkDiscount < ApplicationRecord
    validates :percent_discount, numericality: { less_than_or_equal_to: 100, only_integer: true }
    validates :quantity_threshold, numericality: { only_integer: true }

    belongs_to :merchant
  end