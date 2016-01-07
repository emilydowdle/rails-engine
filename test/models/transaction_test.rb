require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test "random returns one record" do
    transaction = Transaction.create!(result: "success")
    item = Transaction.random

    assert_equal 1, item.count
  end
end
