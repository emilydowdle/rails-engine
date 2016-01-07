class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    merchant_hsh = self.invoices.where(status: "shipped").group(:merchant_id).count
    merchant_id = merchant_hsh.max_by {|k, v| v}[0]
    Merchant.find(merchant_id)
  end

  def self.random
    order("RANDOM()").limit(1)
  end
end
