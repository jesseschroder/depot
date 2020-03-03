require 'test_helper'

class LineItemTest < ActiveSupport::TestCase


  test 'product price change does not affect line item' do
    product = Product.new(title: 'test price stuff', price: 10.00, description: 'descrip', image_url: 'img.gif')
    line_item = LineItem.new(product_id: product.id, price: product.price)

    product.price = 15
    product.save!

    refute_equal product.price, line_item.price
  end
end
