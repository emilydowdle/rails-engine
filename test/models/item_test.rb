require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test "random returns one record" do
    item = Item.random

    assert_equal 1, item.count
    assert_equal Item, item.first.class
  end
end
