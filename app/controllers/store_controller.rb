class StoreController < ApplicationController
    include CurrentCart
    before_action :set_cart
    def index
        @page_title = "this's my page"
        @products = Product.all
        # @cart = set_cart
    end
end
