class FixPercantageDiscountName < ActiveRecord::Migration[5.2]
  def change
    rename_column :bulk_discounts, :percentage_discount, :percent_discount
  end
end
