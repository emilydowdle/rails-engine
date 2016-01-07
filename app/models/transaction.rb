class Transaction < ActiveRecord::Base
  default_scope { order('transactions.id') }

  belongs_to :invoice

  def self.random
    order("RANDOM()").limit(1)
  end
end
