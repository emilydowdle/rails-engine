require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  test "#index responds to json" do
    get :index, format: :json

    assert_response :success
  end

  test "index returns an array of records" do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test "index returns the correct number of merchant items" do
    get :index, format: :json

    assert_equal Merchant.count, json_response.count
  end

  test "#index contains merchant that have the correct properties" do
    get :index, format: :json

    json_response.each do |merchant|
      assert merchant["id"]
      assert merchant["name"]
      assert merchant["created_at"]
      assert merchant["updated_at"]
    end
  end

  test "#show responds to json" do
    get :show, format: :json, id: Merchant.first.id

    assert_response :success
  end

  test "#show returns one record" do
    get :show, format: :json, id: Merchant.first.id

    assert_kind_of Hash, json_response
  end

  test "#show returns the correct merchant items" do
    get :show, format: :json, id: Merchant.first.id

    assert_equal Merchant.first.id, json_response["id"]
  end

  test "#find returns an merchant items when searched by id" do
    merchant_id = Merchant.first.id
    get :find, id: merchant_id, format: :json

    assert_response :success
    assert_kind_of Hash, json_response
    assert_equal merchant_id, json_response["id"]

    assert_equal Merchant.first.updated_at, json_response["updated_at"]
    assert_equal Merchant.first.name, json_response["name"]
  end

  test "#find returns an merchant items when searched by name" do
    merchant_name = Merchant.first.name
    get :find, name: merchant_name, format: :json

    assert_response :success
    assert_kind_of Hash, json_response
    assert_equal merchant_name, json_response["name"]

    assert_equal Merchant.first.updated_at, json_response["updated_at"]
    assert_equal Merchant.first.created_at, json_response["created_at"]
  end

  test "#find all returns an collection of merchant items when searched by quantity" do
    merchant = Merchant.first.name
    get :find_all, name: merchant, format: :json

    assert_response :success
    assert_equal 2, json_response.count
    assert_kind_of Array, json_response
    assert_equal merchant, json_response.first["name"]
    assert_equal Merchant.first.created_at, json_response.first["created_at"]
  end

  test "#random returns an merchant items from the database" do
    get :random, format: :json

    assert_response :success
    assert_kind_of Array, json_response
  end

  test "#invoices returns an empty collection of invoices" do
    merchant_id = Merchant.first.id
    get :invoices, id: merchant_id, format: :json

    assert_response :success
    assert ([]), json_response
  end

  test "#items returns an empty collection of items" do
    merchant_id = Merchant.first.id
    get :items, id: merchant_id, format: :json

    assert_response :success
    assert ([]), json_response
  end
end
