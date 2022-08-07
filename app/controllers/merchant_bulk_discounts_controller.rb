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
        bulk_discount = BulkDiscount.new(merchant_bulk_discount_params)
 
        if bulk_discount.save
          redirect_to "/merchants/#{bulk_discount.merchant.id}/bulk_discounts"
        else
          redirect_to "/merchants/#{bulk_discount.merchant.id}/bulk_discounts/new"
          flash[:alert] = "Error: #{error_message(bulk_discount.errors)}"
        end 
    end

    def destroy
      bulk_discount = BulkDiscount.find(params[:bulk_discount_id]).destroy
      redirect_to "/merchants/#{bulk_discount.merchant.id}/bulk_discounts"
    end

    def edit
      @bulk_discount = BulkDiscount.find(params[:bulk_discount_id])
    end

    private

    def merchant_bulk_discount_params
      params.permit(:percent_discount, :quantity_threshold, :merchant_id)
    end
end