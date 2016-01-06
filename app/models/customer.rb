class Customer < ActiveRecord::Base
  default_scope { order('id') }

  has_many :invoices
  has_many :transactions, through: :invoices
end
