module CurrentCart
    private

    def set_cart
        # debugger if session[:cart_id].present?

        @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
        @cart = Cart.create
        # debugger
        session[:cart_id] = @cart.id
        # debugger
    end

end