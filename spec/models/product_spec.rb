require 'rails_helper'

describe Product do
  describe 'POST #create' do
    it "商品名が空だと登録不可なこと" do
      product = build(:product, name: "" )
      product.valid?
      expect(product.errors[:name]).to include("を入力してください")
    end

    it "商品名が四十文字以内だと登録可能なこと" do
      user = create(:user)
      product = build(:product, seller_id: user.id, name: Faker::Base.regexify("[aあ]{40}") )
      expect(product).to be_valid
    end

    it "商品名が四十文字以上だと登録不可なこと" do
      product = build(:product, name: Faker::Base.regexify("[aあ]{41}") )
      product.valid?
      expect(product.errors[:name]).to include("は40文字以内で入力してください")
    end

    it "値段が空だと登録不可なこと" do
      product = build(:product, price: "")
      product.valid?
      expect(product.errors[:price]).to include("は300円から9999999円以内にしてください")
    end

    it "値段が文字だと登録不可なこと" do
      product = build(:product, price: "あああ")
      product.valid?
      expect(product.errors[:price]).to include("は300円から9999999円以内にしてください")
    end

    it "値段が300よりも小さければ登録不可なこと" do
      product = build(:product, price: 299)
      product.valid?
      expect(product.errors[:price]).to include("は300円から9999999円以内にしてください")
    end

    it "値段が300ならば登録可能なこと" do
      user = create(:user)
      product = build(:product, seller_id: user.id, price: 300)
      expect(product).to be_valid
    end

    it "値段が9,999,999ならば登録可能なこと" do
      user = create(:user)
      product = build(:product, seller_id: user.id, price: 9999999)
      expect(product).to be_valid
    end

    it "値段が10,000,000ならば登録不可なこと" do
      product = build(:product, price: 10000000)
      product.valid?
      expect(product.errors[:price]).to include("は300円から9999999円以内にしてください")
    end

    it "カテゴリーが空白ならば登録不可なこと" do
      product = build(:product, category_id: "")
      product.valid?
      expect(product.errors[:category_id]).to include("を選択してください")
    end

    it "カテゴリーが親ならば登録不可なこと" do
      product = build(:product, category_id: 1)
      product.valid?
      expect(product.errors[:category_id]).to include("を選択してください")
    end

    it "カテゴリーが子ならば登録不可なこと" do
      product = build(:product, category_id: 2)
      product.valid?
      expect(product.errors[:category_id]).to include("を選択してください")
    end

    it "カテゴリーが孫ならば登録可能なこと" do
      user = create(:user)
      product = build(:product, seller_id: user.id, category_id: "3")
      expect(product).to be_valid
    end

    it "商品説明が空白なら登録不可" do
      product = build(:product, description: "")
      product.valid?
      expect(product.errors[:description]).to include("を入力してください")
    end

    it "商品説明が1,000文字なら登録可能なこと" do
      user = create(:user)
      product = build(:product,seller_id: user.id, description: Faker::Base.regexify("[aあ]{1000}"))
      product.valid?
      expect(product).to be_valid
    end

    it "商品説明が1,001文字なら登録不可なこと" do
      product = build(:product, description:  Faker::Base.regexify("[aあ]{1001}"))
      product.valid?
      expect(product.errors[:description]).to include("は1000文字以内で入力してください")
    end

    it "ステータスが空白なら登録不可なこと" do
      product = build(:product, status_id: "")
      product.valid?
      expect(product.errors[:status_id]).to include("を選択してください")
    end

    it "配送料が空白なら登録不可なこと" do
      product = build(:product, shipfee_id: "")
      product.valid?
      expect(product.errors[:shipfee_id]).to include("を選択してください")
    end

    it "発送元の地域が空白なら登録不可なこと" do
      product = build(:product, shipregion_id: "")
      product.valid?
      expect(product.errors[:shipregion_id]).to include("を選択してください")
    end

    it "発送までの日数が空白なら登録不可なこと" do
      product = build(:product, estshipdate_id: "")
      product.valid?
      expect(product.errors[:estshipdate_id]).to include("を選択してください")
    end

    it "商品名, 値段, カテゴリー, 商品説明, ステータス, 配送料, 発送元の地域, 配送までの日数が入っていると登録可能なこと" do
      user = create(:user)
      product = build(:product, seller_id: user.id)
      expect(product).to be_valid
    end
  end
end