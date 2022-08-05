require 'rails_helper'

RSpec.describe BulkDiscount do
  describe 'validations' do
    it { should validate_presence_of(:percent_discount) }
    it { should validate_presence_of(:quantity_threshold) }
  end

#   describe 'relationships' do
#     it { should have_many :invoices }
#     it { should have_many(:invoice_items).through(:invoices)}
#     it { should have_many(:items).through(:invoice_items)}
#     it { should have_many(:merchants).through(:items)}
#   end
end