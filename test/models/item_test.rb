require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test "random returns one record" do
    item = Item.random

    assert_equal 1, item.count
  end
end
