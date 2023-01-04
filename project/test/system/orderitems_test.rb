require "application_system_test_case"

class OrderitemsTest < ApplicationSystemTestCase
  setup do
    @orderitem = orderitems(:one)
  end

  test "visiting the index" do
    visit orderitems_url
    assert_selector "h1", text: "Orderitems"
  end

  test "should create orderitem" do
    visit orderitems_url
    click_on "New orderitem"

    fill_in "Image", with: @orderitem.image
    fill_in "Num", with: @orderitem.num
    fill_in "Order", with: @orderitem.order_id
    fill_in "Price", with: @orderitem.price
    fill_in "Title", with: @orderitem.title
    click_on "Create Orderitem"

    assert_text "Orderitem was successfully created"
    click_on "Back"
  end

  test "should update Orderitem" do
    visit orderitem_url(@orderitem)
    click_on "Edit this orderitem", match: :first

    fill_in "Image", with: @orderitem.image
    fill_in "Num", with: @orderitem.num
    fill_in "Order", with: @orderitem.order_id
    fill_in "Price", with: @orderitem.price
    fill_in "Title", with: @orderitem.title
    click_on "Update Orderitem"

    assert_text "Orderitem was successfully updated"
    click_on "Back"
  end

  test "should destroy Orderitem" do
    visit orderitem_url(@orderitem)
    click_on "Destroy this orderitem", match: :first

    assert_text "Orderitem was successfully destroyed"
  end
end
