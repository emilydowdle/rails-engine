class Transaction < ActiveRecord::Base
  default_scope { order('id') }

  belongs_to :invoice
end
