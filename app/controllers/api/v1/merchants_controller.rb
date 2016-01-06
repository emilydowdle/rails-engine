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
    respond_with Merchant.find(params[:id]).items
  end

  def items
    respond_with Merchant.find(params[:id]).invoices
  end

  def most_revenue
    # for all merchants
    # GET /api/v1/merchants/most_revenue?quantity=x returns the top x merchants ranked by total revenue
    successful_transactions = Transaction.where(result: "success")
    result = successful_transactions.map do |transaction|
      transaction.invoice.merchant
    end
    # result = ""
    respond_with result

    Company.includes(:persons).where(:persons => { active: true } ).all

@companies.each do |company|
     company.person.name
end
  end

  def most_items
    # for all merchants
    # GET /api/v1/merchants/revenue?date=x returns the total revenue for date x across all merchants
  end

  def revenue
    # for all merchants
    # GET /api/v1/merchants/most_items?quantity=x returns the top x merchants ranked by total number of items sold
  end

  private

    def merchant_params
      params.permit(:id,
                    :name,
                    :created_at,
                    :updated_at)
    end
end
