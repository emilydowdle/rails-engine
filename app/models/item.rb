class Item < ActiveRecord::Base
  default_scope { order('id') }

  before_save :format_dollar

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  private

  def format_dollar
    self.unit_price = unit_price / 100.00
  end

  def best_day
    

    # customer_purchases_hsh = self.invoices.where(status: "shipped").group(:customer_id).count
    # customer_id = customer_purchases_hsh.max_by {|k, v| v}[0]
    # Customer.find(customer_id)
  end
end
