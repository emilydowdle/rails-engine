class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with find_merchant
  end

  def find
    respond_with Merchant.find_by(merchant_params)
  end

  def find_all
    respond_with Merchant.where(merchant_params)
  end

  def random
    respond_with Merchant.random
  end

  def invoices
    respond_with find_merchant.invoices
  end

  def items
    respond_with find_merchant.items
  end

  def most_revenue
    respond_with Merchant.merchants_sorted_by_revenue(params).take(params[:quantity].to_i)
  end

  def revenue_by_date
    respond_with Merchant.revenue_by_date(params)
  end

  def revenue
    respond_with find_merchant.single_merchant_revenue(params)
  end

  def favorite_customer
    respond_with find_merchant.favorite_customer
  end

  def customers_with_pending_invoices
    respond_with find_merchant.pending_invoices
  end

  private

    def find_merchant
      Merchant.find(params[:id])
    end

    def merchant_params
      params.permit(:id,
                    :name,
                    :created_at,
                    :updated_at)
    end
end
