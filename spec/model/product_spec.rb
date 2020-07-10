require 'rails_helper'

describe Product do
  describe '#create' do
    it "is invalid without a name" do
      product = build(:product, name: "" )
      product.valid?

      expect(product.errors[:name]).to include("を入力してください")
    end

    it "is valid 40 char name" do
      product = build(:product, name: Faker::Base.regexify("[aあ]{40}") )
      product.valid?

      expect(product).to be_valid
    end

    it "is invalid upper 41 char name" do
      product = build(:product, name: Faker::Base.regexify("[aあ]{41}") )
      product.valid?

      expect(product.errors[:name]).to include("は40文字以内で入力してください")
    end

    it "is invalid without a price" do
      product = build(:product, price: "")
      product.valid?

      expect(product.errors[:price]).to include("を入力してください")
    end

    it "is invalid without a category_id" do
      product = build(:product, category_id: "")
      product.valid?

      expect(product.errors[:category_id]).to include("を選択してください")
    end

    it "is invalid without a description" do
      product = build(:product, description: "")
      product.valid?

      expect(product.errors[:description]).to include("を入力してください")
    end

    it "is valid 1000 char discription" do
      product = build(:product, description:  Faker::Base.regexify("[aあ]{1000}"))
      product.valid?

      expect(product).to be_valid
    end

    it "is invalid upper 1001 char discription" do
      product = build(:product, description:  Faker::Base.regexify("[aあ]{1001}"))
      product.valid?

      expect(product.errors[:description]).to include("は1000文字以内で入力してください")
    end

    it "is invalid without a status_id" do
      product = build(:product, status_id: "")
      product.valid?
      
      expect(product.errors[:status_id]).to include("を選択してください")
    end

    it "is invalid without a shipfee_id" do
      product = build(:product, shipfee_id: "")
      product.valid?
      
      expect(product.errors[:shipfee_id]).to include("を選択してください")
    end

    it "is invalid without a shipregion_id" do
      product = build(:product, shipregion_id: "")
      product.valid?
      
      expect(product.errors[:shipregion_id]).to include("を選択してください")
    end

    it "is invalid without a estshipdate_id" do
      product = build(:product, estshipdate_id: "")
      product.valid?
      
      expect(product.errors[:estshipdate_id]).to include("を選択してください")
    end 
    
    it "is valid with a name, price, category_id, description, status_id, shipfee_id, shipregion_id, estshipdate_id" do
      product = build(:product)
      
      expect(product).to be_valid
    end
  end
end