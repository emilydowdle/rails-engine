require 'test_helper'

class Api::V1::TransactionsControllerTest < ActionController::TestCase
  test "#index responds to json" do
    get :index, format: :json

    assert_response :success
  end

  test "index returns an array of records" do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test "index returns the correct number of transaction items" do
    get :index, format: :json

    assert_equal Transaction.count, json_response.count
  end

  test "#index contains transaction that have the correct properties" do
    get :index, format: :json

    json_response.each do |transaction|
      assert transaction["id"]
      assert transaction["credit_card_number"]
      assert transaction["result"]
      assert transaction["created_at"]
      assert transaction["updated_at"]
    end
  end

  test "#show responds to json" do
    get :show, format: :json, id: Transaction.first.id

    assert_response :success
  end

  test "#show returns one record" do
    get :show, format: :json, id: Transaction.first.id

    assert_kind_of Hash, json_response
  end

  test "#show returns the correct transaction items" do
    get :show, format: :json, id: Transaction.first.id

    assert_equal Transaction.first.id, json_response["id"]
  end

  test "#find returns an transaction items when searched by id" do
    transaction_id = Transaction.first.id
    get :find, id: transaction_id, format: :json

    assert_response :success
    assert_kind_of Hash, json_response
    assert_equal transaction_id, json_response["id"]

    assert_equal Transaction.first.updated_at, json_response["updated_at"]
    assert_equal Transaction.first.result, json_response["result"]
  end

  test "#find returns an transaction items when searched by name" do
    transaction = Transaction.first.result
    get :find, name: transaction, format: :json

    assert_response :success
    assert_kind_of Hash, json_response
    assert_equal transaction, json_response["result"]

    assert_equal Transaction.first.updated_at, json_response["updated_at"]
    assert_equal Transaction.first.created_at, json_response["created_at"]
  end

  test "#find all returns an collection of transaction items when searched by quantity" do
    transaction = Transaction.first.result
    get :find_all, name: transaction, format: :json

    assert_response :success
    assert_equal 2, json_response.count
    assert_kind_of Array, json_response
    assert_equal transaction, json_response.first["result"]
    assert_equal Transaction.first.created_at, json_response.first["created_at"]
  end

  test "#random returns an transaction items from the database" do
    get :random, format: :json

    assert_response :success
    assert_kind_of Hash, json_response
  end
end
