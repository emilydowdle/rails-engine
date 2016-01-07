class Api::V1::InvoiceItemsController < ApplicationController
  respond_to :json

  def index
    respond_with InvoiceItem.all
  end

  def show
    respond_with find_invoice
  end

  def find
    respond_with InvoiceItem.find_by(invoice_item_params)
  end

  def find_all
    respond_with InvoiceItem.where(invoice_item_params)
  end

  def random
    respond_with InvoiceItem.random
  end

  def invoice
    respond_with find_invoice.invoice
  end

  def item
    respond_with find_invoice.item
  end

  private

    def find_invoice
      InvoiceItem.find(params[:id])
    end

    def invoice_item_params
      params.permit(:id,
                    :quantity,
                    :unit_price,
                    :item_id,
                    :invoice_id,
                    :created_at,
                    :updated_at)
    end
end
