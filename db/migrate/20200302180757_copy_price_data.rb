class CopyPriceData < ActiveRecord::Migration[6.0]
  def up
    LineItem.all.each do |line_item|
      product_price = Product.find(line_item.product_id).price
      line_item.price = product_price
      line_item.save!
    end
  end
end
