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
end
