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

  test "favorite customer returns correct customer" do
    customer = Customer.create!(first_name: "John",
                                last_name: "Doe")
    customer_two = Customer.create!(first_name: "Sally",
                                    last_name: "Sue")

    merchant = Merchant.create!(name: "Wesley")

    Invoice.create!(merchant_id: merchant.id, customer_id: customer.id, status: "shipped")

    assert_equal "John", merchant.favorite_customer.first_name
  end
end
