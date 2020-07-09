require 'rails_helper'

describe Product do
  describe '#create' do
    it "not name" do
      product = Product.new(name: "", price: "1000", category_id: 1, description: "setumei", status_id: 1, shipfee_id: 1, shipregion_id: 2, estshipdate_id: 4, seller_id: 1, images_attributes: {"0"=>{"src"=>"hoge.jpg"}})
      product.valid?

      expect(product.errors[:name]).to include("can't be blank")
    end

    it "not price" do
      product = Product.new(name: "tanaka", price: "", category_id: 1, description: "setumei", status_id: 1, shipfee_id: 1, shipregion_id: 2, estshipdate_id: 4, seller_id: 1, images_attributes: {"0"=>{"src"=>"hoge.jpg"}})
      product.valid?

      expect(product.errors[:price]).to include("can't be blank")
    end

    it "not category" do
      product = Product.new(name: "tanaka", price: "1000", category_id: "", description: "setumei", status_id: 1, shipfee_id: 1, shipregion_id: 2, estshipdate_id: 4, seller_id: 1, images_attributes: {"0"=>{"src"=>"hoge.jpg"}})
      product.valid?

      expect(product.errors[:category_id]).to include("can't be blank")
      expect(product.errors[:category]).to include("must exist")
    end
  end
end