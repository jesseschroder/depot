require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  def new_product(image_url)
    Product.new(title: 'My Book', description: 'My book is boring', price: 1, image_url: image_url)
  end

  test 'product attributes must not be empty' do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test 'product price must be positive' do
    product = Product.new(title: 'My Book Title', description: 'test', image_url: 'test.jpj')

    product.price = -1
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]
  end

  test 'product price cannot be 0' do
    product = Product.new(title: 'My Book Title', description: 'test', image_url: 'test.jpj')

    product.price = 0
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]
  end

  test 'product price is valid as a positive number' do
    product = Product.new(title: 'My Book Title', description: 'test', image_url: 'test.jpg')

    product.price = 1
    assert product.valid?
  end

  test 'image url validates' do
    good = %w{ fred.gif fred.jpg fred.png FRED.JPG Fred.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    good.each { |i| assert new_product(i).valid?, "#{i} shouldn't be invalid" }
    bad.each { |i| assert new_product(i), "#{i} shouldn't be valid"}
  end


end
