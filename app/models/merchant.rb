class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices

  def transactions
    invoices.order('invoices.id').joins(:transactions,:invoice_items)
  end

  def single_merchant_revenue(params)
    if params[:date]
      sum_of_successful_transactions_by_date(params[:date])
    else
      sum_of_successful_transactions
    end
  end

  def sum_of_successful_transactions
    total = self.invoices.successful.joins(:invoice_items)
    .sum("invoice_items.quantity * invoice_items.unit_price").to_s
    { "revenue" => total }
  end

  def sum_of_successful_transactions_by_date(date)
    total = self.invoices.where(created_at: date).successful
    .joins(:invoice_items)
    .sum("invoice_items.quantity * invoice_items.unit_price").to_s
    { "revenue" => total }
  end

  def favorite_customer
    customer_purchases_hsh = self.invoices.where(status: "shipped")
    .group(:customer_id).count
    customer_id = customer_purchases_hsh.max_by {|k, v| v}[0]
    Customer.find(customer_id)
  end

  def self.revenue_by_date(params)
    total = Invoice.joins(:transactions, :invoice_items)
    .where("transactions.result = ? AND invoices.created_at = ?", "success", params[:date])
    .sum("invoice_items.quantity * invoice_items.unit_price")
    { "total_revenue" => total }
  end
end
