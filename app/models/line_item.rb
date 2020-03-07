class LineItem < ApplicationRecord
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  belongs_to :order, optional: true
  belongs_to :product
  belongs_to :cart

  def total_price
    price * quantity
  end
end
