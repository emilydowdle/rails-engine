class InvoiceItem < ActiveRecord::Base
  default_scope { order('invoice_items.id') }

  before_save :format_dollar

  belongs_to :item
  belongs_to :invoice

  private

  def format_dollar
    self.unit_price = unit_price / 100.00
  end

  def self.random
    order("RANDOM()").limit(1)
  end
end
