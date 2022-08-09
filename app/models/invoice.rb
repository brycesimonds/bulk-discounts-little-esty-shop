class Invoice < ApplicationRecord
  validates_presence_of :status

  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  enum status: { "in progress" => 0, "cancelled" => 1, "completed" => 2 }

  def self.incomplete_invoices
  joins(:invoice_items)
  .where.not(invoice_items: { status: 2 })
  .order(:created_at)
  .distinct
  end

  def total_revenue
   invoice_items.sum("unit_price * quantity")
  end

  def discounted_revenue
    total_revenue - bulk_discounts.select('bulk_discounts.*, invoice_items.*, sum((invoice_items.unit_price * invoice_items.quantity * bulk_discounts.percent_discount)/100) as discounted_revenue')
                                  .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
                                  .group('bulk_discounts.id, invoice_items.id')
                                  .order("percent_discount desc")
                                  .limit(1)
                                  .first
                                  .discounted_revenue
  end
end
