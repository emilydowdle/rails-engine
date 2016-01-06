class Merchant < ActiveRecord::Base
  include GlobalModelMethods
  # default_scope { order('id') }

  has_many :items
  has_many :invoices

  # Notes on Magic:
  # * I had to update your models. They all used "default_scope" with order('id')
  #   that messes up the ORDER BY statements when we're joining all over. To see the error
  #   change the one in the invoice model.
  # * Your total revenue method doesn't use my methods. Just update it to use them when
  #   you understand them.
  # * Don't worry - This isn't easy. You're doing great! :D

  # Begin Magic
  def transactions
    # This logic could be moved into invoies or transaction model(s)
    invoices.order('invoices.id').joins(:transactions,:invoice_items)
  end

  def successful_transactions
    # This logic could be moved into invoies or transaction model(s)
    transactions.where("transactions.result": "success")
  end

  def sum_of_successful_transactions_new
    successful_transactions.group('invoices.id').sum("invoice_items.unit_price")
  end
  # End Magic

  def sum_of_successful_transactions
    self.invoices.successful.joins(:invoice_items).sum("invoice_items.quantity * invoice_items.unit_price").to_s
  end

  def total_revenue(date=nil)
    #  SUM OF SUCCESSFUL TRANSACTIONS WORKS, BY DATE DOES NOT
    if date == nil
      total = sum_of_successful_transactions
    else
      # total = self.invoices.successful.joins(:transactions, :invoice_items)
      #             .where("transactions.updated_at": date)
                  # .group(:id) # this works
                  # .where("transactions.result": "success")
                  # .where("transactions.updated_at > ? and transactions.updated_at < ?", "#{date} 00:00:00 -0600", "#{date} 23:59:59 -0600")
                  # .sum("invoice_items.unit_price")
    end
    # { "revenue" => (convert_cents_to_dollar(total).to_s) }
  end

  def favorite_customer
    customer_purchases_hsh = self.invoices.where(status: "shipped").group(:customer_id).count
    customer_id = customer_purchases_hsh.max_by {|k, v| v}[0]
    Customer.find(customer_id)
  end
end
