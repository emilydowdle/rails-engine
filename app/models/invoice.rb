class Invoice < ActiveRecord::Base
  default_scope { order('id') }

  belongs_to :merchant
  belongs_to :customer

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
end
