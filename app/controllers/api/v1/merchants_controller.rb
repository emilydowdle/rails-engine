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
    respond_with Merchant.offset(rand(Merchant.count)).first
  end

  def invoices
    respond_with find_merchant.invoices
  end

  def items
    respond_with find_merchant.items
  end

  # def most_revenue
  #   # for all merchants
  #   # GET /api/v1/merchants/most_revenue?quantity=x returns the top x merchants ranked by total revenue
  #   respond_with Merchant.most_revenue
  # end

  def revenue_by_date
    respond_with Merchant.revenue_by_date(params)
    # for all merchants
    # GET /api/v1/merchants/revenue?date=x returns the total revenue for date x across all merchants
  end

  # def revenue_all
  #   # for all merchants
  #   # GET /api/v1/merchants/most_items?quantity=x returns the top x merchants ranked by total number of items sold
  # end

  def revenue
    respond_with find_merchant.single_merchant_revenue(params)
  end

  def favorite_customer
    respond_with find_merchant.favorite_customer
  end

  def customers_with_pending_invoices
    # for one merchant
    # GET /api/v1/merchants/:id/customers_with_pending_invoices returns a collection of customers which have pending (unpaid) invoices
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
