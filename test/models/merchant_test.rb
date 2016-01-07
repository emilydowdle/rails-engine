require 'test_helper'

class MerchantTest < ActiveSupport::TestCase  
  test "merchant has many invoices" do
    create_merchant_customer_invoice

    assert_equal @invoice.id, @merchant.invoices.first.id
  end

  test "merchant has many items" do
    create_merchant_customer_invoice

    assert_equal @item.id, @merchant.items.first.id
  end

  test "favorite customer returns correct customer" do
    create_merchant_customer_invoice

    assert_equal "John", @merchant.favorite_customer.first_name
  end

  test "sum of successful transactions returns correct revenue data" do
    create_merchant_customer_invoice

    assert_equal ({"revenue"=>"0.25"}), @merchant.sum_of_successful_transactions
  end

  test "sum of successful transactions by date returns correct revenue data" do
    create_merchant_customer_invoice

    assert_equal ({"revenue"=>"0.25"}), @merchant.sum_of_successful_transactions_by_date("2012-03-27 14:54:09")
  end

  test "revenue for merchants returns sum of revenue for individual merchant" do
    create_merchant_customer_invoice

    assert_equal "0.25", @merchant.revenue_for_merchants
  end

  def create_merchant_customer_invoice
    @merchant      = Merchant.create!(name: "Wesley")

    @customer      = Customer.create!(first_name: "John",
                                      last_name: "Doe")

    @customer_two  = Customer.create!(first_name: "Sally",
                                      last_name: "Sue")

    @item          = Item.create!(name: "Item",
                                  unit_price: 9,
                                  merchant_id: @merchant.id)

    @invoice       = Invoice.create!(merchant_id: @merchant.id,
                                     customer_id: @customer.id,
                                     status: "shipped",
                                     created_at: "2012-03-27 14:54:09",
                                     updated_at: "2012-03-27 14:54:09")

    @transaction   = Transaction.create!(result: "success",
                                         invoice_id: @invoice.id)

    @invoice_items = InvoiceItem.create!(quantity: 5,
                                         unit_price: 5,
                                         invoice_id: @invoice.id,
                                         item_id: @item.id,
                                         created_at: "2012-03-27 14:54:09",
                                         updated_at: "2012-03-27 14:54:09")
  end
end
