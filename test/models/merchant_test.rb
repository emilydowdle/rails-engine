require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  test "merchant has many invoices" do
    merchant = Merchant.create!(name: "Schroeder-Jerde")
    invoice = Invoice.create!(status: "shipped", merchant_id: merchant.id)

    assert_equal invoice.id, merchant.invoices.first.id
  end

  test "merchant has many items" do
    merchant = Merchant.create!(name: "Schroeder-Jerde")
    item = Item.create!(name: "Item", unit_price: 9, merchant_id: merchant.id)

    assert_equal item.id, merchant.items.first.id
  end
end
