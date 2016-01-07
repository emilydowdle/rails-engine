class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices

  def self.random
    order("RANDOM()").limit(1)
  end

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

  def revenue_for_merchants
    total = self.invoices.successful
    .joins(:invoice_items)
    .sum("invoice_items.quantity * invoice_items.unit_price").to_s
  end

  def self.merchants_sorted_by_revenue
    all.sort{|a, b| a.revenue_for_merchants <=> b.revenue_for_merchants}
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

  def pending_invoices
    customer_ids = self.invoices.joins(:transactions, :customer).where(transactions: { result:"failed" }).pluck(:customer_id).uniq
    Customer.where(id: customer_ids)
  end
end
