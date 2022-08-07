class MerchantBulkDiscountsController < ApplicationController
    def index
        @merchant = Merchant.find(params[:merchant_id])
    end

    def show
        @bulk_discount = BulkDiscount.find(params[:bulk_discount_id])
    end

    def new
        @merchant = Merchant.find(params[:merchant_id])
    end

    def create
        merchant = Merchant.find(params[:merchant_id])

        merchant_discount = BulkDiscount.new(merchant_bulk_discount_params)
    
        if merchant_discount.save
          redirect_to "/merchants/#{merchant.id}/bulk_discounts"
        else
          redirect_to "/merchants/#{merchant.id}/bulk_discounts/new"
          flash[:alert] = "Error: #{error_message(merchant_discount.errors)}"
        end 
    end

    private

    def merchant_bulk_discount_params
      params.permit(:percent_discount, :quantity_threshold, :merchant_id)
    end
end