class BulkDiscount < ApplicationRecord
    validates :percent_discount, numericality: { only_integer: true }
    validates :quantity_threshold, numericality: { only_integer: true }

    belongs_to :merchant
  end