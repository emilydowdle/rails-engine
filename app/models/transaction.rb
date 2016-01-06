class Transaction < ActiveRecord::Base
  default_scope { order('transactions.id') }

  belongs_to :invoice
end
