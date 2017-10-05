  require 'test_helper'

class BookingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @booking = bookings(:one)
  end


  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get bookings_create_url
    assert_response :success
  end

  test "should get update" do
    get bookings_update_url
    assert_response :success
  end

  test "should get edit" do
    get bookings_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get bookings_destroy_url
    assert_response :success
  end

  test "should get index" do
    get bookings_index_url
    assert_response :success
  end

  test "should get show" do
    get bookings_show_url
    assert_response :success
  end

end
