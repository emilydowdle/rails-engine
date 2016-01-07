require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  test "random returns one record" do
    invoice = Invoice.create!(status: "shipped")
    item = Invoice.random

    assert_equal 1, item.count
  end
end
