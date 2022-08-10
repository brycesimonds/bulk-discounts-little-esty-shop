class CreateBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discounts do |t|
      t.references :merchant, foreign_key: true
      t.integer :percent_discount
      t.integer :quantity_threshold
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
