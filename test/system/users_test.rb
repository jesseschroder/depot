require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "creating a User" do
    visit users_url
    click_on "New User"

    fill_in "Name", with: "Not Jesse"
    fill_in "Password", with: 'secret'
    fill_in "Confirm password:", with: 'secret'
    click_on "Create User"

    assert_text "User Not Jesse was successfully created"
  end

  test "updating a User" do
    skip
    visit users_url
    click_on "Edit", match: :first

    fill_in "Name", with: @user.name
    fill_in "Password", with: 'secret'
    fill_in "Confirm password:", with: 'secret'
    fill_in "Validate current password:", with: 'secret'
    click_on "Update User"

    assert_text "User was successfully updated"
  end

  test "destroying a User" do
    visit users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Please Log In"
  end
end
