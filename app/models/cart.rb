class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy

    def total_price
        price = 0
        line_items.each do |line_item|
            price += line_item.quantity * line_item.product.price
        end
        price
    end
end
