require 'rails_helper'

RSpec.describe BulkDiscount do
  describe 'validations' do
    it { should validate_numericality_of(:percent_discount) }
    it { should validate_numericality_of(:quantity_threshold) }
  end

  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:items).through(:merchant) }
    it { should have_many(:invoice_items).through(:items) }
  end
end

