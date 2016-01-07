class Invoice < ActiveRecord::Base
  belongs_to :merchant
  belongs_to :customer

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.successful
    joins(:transactions).where(transactions: { result: "success" })
  end

  def self.random
    order("RANDOM()").limit(1)
  end
end
