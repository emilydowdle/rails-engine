class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find(params[:id])
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
    respond_with Merchant.find(params[:id]).invoices
  end

  def items
    respond_with Merchant.find(params[:id]).items
  end

  def most_revenue
    # for all merchants
    # GET /api/v1/merchants/most_revenue?quantity=x returns the top x merchants ranked by total revenue
    respond_with MerchantDataParser.new.sort_merchants_by_sales
    # (params[:x])
  end

  def most_items
    # for all merchants
    # GET /api/v1/merchants/revenue?date=x returns the total revenue for date x across all merchants
  end

  def revenue_all
    # for all merchants
    # GET /api/v1/merchants/most_items?quantity=x returns the top x merchants ranked by total number of items sold
  end

  def revenue
    # for one merchant
    # GET /api/v1/merchants/:id/revenue returns the total revenue for that merchant across all transactions
    # GET /api/v1/merchants/:id/revenue?date=x returns the total revenue for that merchant for a specific invoice date x
    respond_with Merchant.find(params[:id]).total_revenue(params[:date])
  end

  def favorite_customer
    respond_with Merchant.find(params[:id]).favorite_customer
  end

  def customers_with_pending_invoices
    # for one merchant
    # GET /api/v1/merchants/:id/customers_with_pending_invoices returns a collection of customers which have pending (unpaid) invoices
  end

  private

    def merchant_params
      params.permit(:id,
                    :name,
                    :created_at,
                    :updated_at)
    end
end
