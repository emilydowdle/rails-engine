require 'test_helper'

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase
  test "invoice items #index responds to json" do
    get :index, format: :json

    assert_response :success
  end

  test "invoice items index returns an array of records" do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test "invoice items index returns the correct number of invoice items" do
    get :index, format: :json

    assert_equal InvoiceItem.count, json_response.count
  end

  test "invoice items #index contains invoice items that have the correct properties" do
    get :index, format: :json

    json_response.each do |invoice_items|
      assert invoice_items["id"]
      assert invoice_items["quantity"]
      assert invoice_items["unit_price"]
      assert invoice_items["created_at"]
      assert invoice_items["updated_at"]
    end
  end

  test "invoice items #show responds to json" do
    get :show, format: :json, id: InvoiceItem.first.id

    assert_response :success
  end

  test "invoice items #show returns one record" do
    get :show, format: :json, id: InvoiceItem.first.id

    assert_kind_of Hash, json_response
  end

  test "invoice items #show returns the correct invoice items" do
    get :show, format: :json, id: InvoiceItem.first.id

    assert_equal InvoiceItem.first.id, json_response["id"]
  end

  test "#find returns an invoice items when searched by id" do
    invoice_item_id = InvoiceItem.first.id
    get :find, id: invoice_item_id, format: :json

    assert_response :success
    assert_kind_of Hash, json_response
    assert_equal invoice_item_id, json_response["id"]

    assert_equal InvoiceItem.first.updated_at, json_response["updated_at"]
    assert_equal InvoiceItem.first.quantity, json_response["quantity"]
  end

  test "#find returns an invoice items when searched by name" do
    invoice_items_quantity = InvoiceItem.first.quantity
    get :find, name: invoice_items_quantity, format: :json

    assert_response :success
    assert_kind_of Hash, json_response
    assert_equal invoice_items_quantity, json_response["quantity"]

    assert_equal InvoiceItem.first.updated_at, json_response["updated_at"]
    assert_equal InvoiceItem.first.created_at, json_response["created_at"]
  end

  test "#find all returns an collection of invoice items when searched by quantity" do
    invoice_item = InvoiceItem.first.quantity
    get :find_all, name: invoice_item, format: :json

    assert_response :success
    assert_equal 2, json_response.count
    assert_kind_of Array, json_response
    assert_equal invoice_item, json_response.first["quantity"]
    assert_equal InvoiceItem.first.created_at, json_response.first["created_at"]
    assert_equal InvoiceItem.first.id, json_response.first["id"]
  end

  test "#random returns an invoice items from the database" do
    get :random, format: :json

    assert_response :success
    assert_kind_of Hash, json_response
  end
end
