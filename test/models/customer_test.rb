require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  test "random returns one record" do
    item = Customer.random

    assert_equal 1, item.count
  end

  test "favorite merchant returns a merchant object" do
    merchant = Merchant.create!(name: "Emily")
    merchant_two = Merchant.create!(name: "Jon")

    customer = Customer.create!(first_name: "John Name",
                                last_name: "Last Name")

    Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")

    assert_equal "Emily", customer.favorite_merchant.name
  end
end
