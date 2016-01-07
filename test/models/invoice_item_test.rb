require 'test_helper'

class InvoiceItemTest < ActiveSupport::TestCase
  test "random returns one record" do
    invoice_item = InvoiceItem.create!(quantity: 4, unit_price: 9)
    item = InvoiceItem.random

    assert_equal 1, item.count
  end
end
