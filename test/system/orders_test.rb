require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper

  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "end to end" do
    LineItem.delete_all
    Order.delete_all

    assert_difference('Order.count', 1) do
      visit store_index_url
      click_on "Add to Cart", match: :first
      click_on "Checkout"

      fill_in "Address", with: @order.address
      fill_in "Email", with: @order.email
      fill_in "Name", with: @order.name
      select "Check", from: 'Pay Type'
      fill_in 'Routing #', with: '123456'
      fill_in 'Account #', with: '123456'
      perform_enqueued_jobs do
        click_on "Place Order"
      end
      assert_text "Thank you for your order!"
    end

    order = Order.order(:created_at).last

    assert_equal 'Ronald McDonald', order.name
    assert_equal 'theclown@mcdonalds.ca', order.email
    assert_equal '99 Rideau', order.address
    assert_equal 'Check', order.pay_type
    assert_equal 1, order.line_items.size

  end

  test "updating a Order" do
    visit orders_url
    click_on "Edit", match: :first

    fill_in "Name", with: 'New Name'
    click_on "Place Order"

    assert_text "Order was successfully updated"
  end

  test "destroying a Order" do
    visit orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end

  test "Check selectors are dynamic" do
    visit store_index_url
    click_on "Add to Cart", match: :first
    click_on "Checkout"

    assert_no_selector "#order_routing_number"
    assert_no_selector "#order_account_number"

    select "Check", from: 'Pay Type'

    assert_selector "#order_routing_number"
    assert_selector "#order_account_number"
  end

  test "Credit card selectors are dynamic" do
    visit store_index_url
    click_on "Add to Cart", match: :first
    click_on "Checkout"

    assert_no_selector "#order_credit_card_number"
    assert_no_selector "#order_expiration_date"

    select "Credit Card", from: 'Pay Type'

    assert_selector "#order_credit_card_number"
    assert_selector "#order_expiration_date"
  end

  test "Purchase order selectors are dynamic" do
    visit store_index_url
    click_on "Add to Cart", match: :first
    click_on "Checkout"

    assert_no_selector "#order_po_number"

    select "Purchase Order", from: 'Pay Type'

    assert_selector "#order_po_number"
  end
end
