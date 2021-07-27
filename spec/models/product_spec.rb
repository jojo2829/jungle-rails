require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before(:each) do
      @category = Category.new(name: "Testcat")
    end

    it "should be valid when all fields are filled" do
      product = Product.new(
        name: "new product",
        price: 200,
        quantity: 1,
        category: @category
      )
      expect(product).to be_valid
      expect(product.errors.full_messages.length).to eql(0)
    end

    it "should be invalid when there's no name" do
      product = Product.new(
        name: nil,
        price: 200,
        quantity: 1,
        category: @category
      )
      expect(product).to be_invalid
      expect(product.errors.full_messages.length).to eql(1)
    end

    it "should be invalid when there's no price" do
      product = Product.new(
        name: "new product",
        price: nil,
        quantity: 1,
        category: @category
      )
      expect(product).to be_invalid
      expect(product.errors.full_messages.length).to eql(3)
    end

    it "should be invalid when there's no quantity" do
      product = Product.new(
        name: "new product",
        price: 200,
        quantity: nil,
        category: @category
      )
      expect(product).to be_invalid
      expect(product.errors.full_messages.length).to eql(1)
    end

    it "should be invalid when there's no category" do
      product = Product.new(
        name: "new product",
        price: 200,
        quantity: 1,
        category: nil
      )
      expect(product).to be_invalid
      expect(product.errors.full_messages.length).to eql(1)
    end

  end
end
