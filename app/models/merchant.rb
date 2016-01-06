class Merchant < ActiveRecord::Base
  default_scope { order('id') }

  has_many :items
  has_many :invoices

end
