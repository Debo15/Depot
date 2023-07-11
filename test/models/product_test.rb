require "test_helper"

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  def new_product(image_url)
    Product.new(name: "xxx", description:"yyy", image_url: image_url, price: 1.0)
  end

  test "Product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:name].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end

  test "Product's price must be positive" do
    product = Product.new(name: "xxx", description: "yyy", image_url: "zzz.png")

    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
                 product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal [ "must be greater than or equal to 0.01"],
                 product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  test "Product's image url must be *.(png/jpg/gif/webp)" do
    ok = %w{hi.png welcome.jpg image.gif iyaad.webp}
    bad = %w{bad.xyz not_good.web not_accepted.com}
    ok.each do |image_url|
      assert new_product(image_url).valid?, "#{image_url} must be valid"
    end
    bad.each do |image_url|
      assert new_product(image_url).invalid?, "#{image_url} must be invalid"
    end
  end

  test "product must have a unique name" do
    product = Product.new(name: products(:one).name, description: "yyy", price:23.2, image_url:"iyaad.png")
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:name]
  end

end
