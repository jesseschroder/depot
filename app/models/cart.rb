class Cart < ApplicationRecord
  has_many :line_items, dependent: :delete_all
end
