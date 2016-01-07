require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase
  test "#index responds to json" do
    get :index, format: :json

    assert_response :success
  end

  test "index returns an array of records" do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test "index returns the correct number of items" do
    get :index, format: :json

    assert_equal Item.count, json_response.count
  end

  test "#index contains items that have the correct properties" do
    get :index, format: :json

    json_response.each do |item|
      assert item["name"]
      assert item["description"]
    end
  end

  test "#show responds to json" do
    get :show, format: :json, id: Item.first.id

    assert_response :success
  end

  test "#show returns one record" do
    get :show, format: :json, id: Item.first.id

    assert_kind_of Hash, json_response
  end

  test "#show returns the correct item" do
    get :show, format: :json, id: Item.first.id

    assert_equal Item.first.id, json_response["id"]
  end

  test "#find returns an item when searched by id" do
    item_id = Item.first.id
    get :find, id: item_id, format: :json

    assert_response :success
    assert_kind_of Hash, json_response
    assert_equal item_id, json_response["id"]

    assert_equal Item.first.name, json_response["name"]
    assert_equal Item.first.description, json_response["description"]
  end

  test "#find returns an item when searched by name" do
    item_name = Item.first.name
    get :find, name: item_name, format: :json

    assert_response :success
    assert_kind_of Hash, json_response
    assert_equal item_name, json_response["name"]

    assert_equal Item.first.id, json_response["id"]
    assert_equal Item.first.description, json_response["description"]
  end

  test "#find all returns an collection of items when searched by name" do
    item_name = Item.first.name
    get :find_all, name: item_name, format: :json

    assert_response :success
    assert_equal 2, json_response.count
    assert_kind_of Array, json_response
    assert_equal item_name, json_response.first["name"]
    assert_equal Item.first.id, json_response.first["id"]
    assert_equal Item.first.description, json_response.first["description"]
  end

  test "#random returns an item from the database" do
    get :random, format: :json

    assert_response :success
    assert_kind_of Array, json_response
  end
end
