require 'test_helper'

class Api::V1::CustomersControllerTest < ActionController::TestCase
  test "#index responds to json" do
    get :index, format: :json

    assert_response :success
  end

  test "index returns an array of records" do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test "index returns the correct number of customers" do
    get :index, format: :json

    assert_equal Customer.count, json_response.count
  end

  test "#index contains customers that have the correct properties" do
    get :index, format: :json

    json_response.each do |customer|
      assert customer["first_name"]
      assert customer["last_name"]
      assert customer["created_at"]
      assert customer["updated_at"]
      assert customer["id"]
    end
  end

  test "#show responds to json" do
    get :show, format: :json, id: Customer.first.id

    assert_response :success
  end

  test "#show returns one record" do
    get :show, format: :json, id: Customer.first.id

    assert_kind_of Hash, json_response
  end

  test "#show returns the correct customer" do
    get :show, format: :json, id: Customer.first.id

    assert_equal Customer.first.id, json_response["id"]
  end

  test "#find returns an customer when searched by id" do
    customer_id = Customer.first.id
    get :find, id: customer_id, format: :json

    assert_response :success
    assert_kind_of Hash, json_response
    assert_equal customer_id, json_response["id"]

    assert_equal Customer.first.updated_at, json_response["updated_at"]
    assert_equal Customer.first.first_name, json_response["first_name"]
  end

  test "#find returns an customer when searched by name" do
    customer_name = Customer.first.first_name
    get :find, name: customer_name, format: :json

    assert_response :success
    assert_kind_of Hash, json_response
    assert_equal customer_name, json_response["first_name"]

    assert_equal Customer.first.updated_at, json_response["updated_at"]
    assert_equal Customer.first.last_name, json_response["last_name"]
  end

  test "#find all returns an collection of customers when searched by name" do
    customer_name = Customer.first.first_name
    get :find_all, name: customer_name, format: :json

    assert_response :success
    assert_equal 2, json_response.count
    assert_kind_of Array, json_response
    assert_equal customer_name, json_response.first["first_name"]
    assert_equal Customer.first.created_at, json_response.first["created_at"]
    assert_equal Customer.first.last_name, json_response.first["last_name"]
  end

  test "#random returns an customer from the database" do
    get :random, format: :json

    assert_response :success
    assert_kind_of Hash, json_response
  end
end
