require 'test_helper'

class Api::V1::InvoicesControllerTest < ActionController::TestCase
  test "#index responds to json" do
    get :index, format: :json

    assert_response :success
  end

  test "index returns an array of records" do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test "index returns the correct number of invoice items" do
    get :index, format: :json

    assert_equal Invoice.count, json_response.count
  end

  test "#index contains invoice that have the correct properties" do
    get :index, format: :json

    json_response.each do |invoice|
      assert invoice["id"]
      assert invoice["status"]
      assert invoice["created_at"]
      assert invoice["updated_at"]
    end
  end

  test "#show responds to json" do
    get :show, format: :json, id: Invoice.first.id

    assert_response :success
  end

  test "#show returns one record" do
    get :show, format: :json, id: Invoice.first.id

    assert_kind_of Hash, json_response
  end

  test "#show returns the correct invoice items" do
    get :show, format: :json, id: Invoice.first.id

    assert_equal Invoice.first.id, json_response["id"]
  end

  test "#find returns an invoice items when searched by id" do
    invoice_id = Invoice.first.id
    get :find, id: invoice_id, format: :json

    assert_response :success
    assert_kind_of Hash, json_response
    assert_equal invoice_id, json_response["id"]

    assert_equal Invoice.first.updated_at, json_response["updated_at"]
    assert_equal Invoice.first.status, json_response["status"]
  end

  test "#find returns an invoice items when searched by name" do
    invoice_status = Invoice.first.status
    get :find, name: invoice_status, format: :json

    assert_response :success
    assert_kind_of Hash, json_response
    assert_equal invoice_status, json_response["status"]

    assert_equal Invoice.first.updated_at, json_response["updated_at"]
    assert_equal Invoice.first.created_at, json_response["created_at"]
  end

  test "#find all returns an collection of invoice items when searched by quantity" do
    invoice = Invoice.first.status
    get :find_all, name: invoice, format: :json

    assert_response :success
    assert_equal 2, json_response.count
    assert_kind_of Array, json_response
    assert_equal invoice, json_response.first["status"]
    assert_equal Invoice.first.created_at, json_response.first["created_at"]
  end

  test "#random returns an invoice items from the database" do
    get :random, format: :json

    assert_response :success
    assert_kind_of Array, json_response
  end
end
