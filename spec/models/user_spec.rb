require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

describe User do

  describe '#create' do

    it "ネームの入力が空かどうか" do
      user = build(:user, name: "")
      user.valid?
      expect(user.errors[:name]).to include("")
    end

    it "Eメールの入力が空かどうか" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("")
    end

    it "パスワードの入力が空かどうか" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("")
    end

    # it "登録されているEメールが重複していないかどうか" do
    #   user = build(:user, email: "sample@sample.com")
    #   user.valid?
    #   expect(user.errors[:email]).to include("")
    # end

    # it "パスワードが７文字以上かどうか" do
    #   user = build(:user, password: "111111")
    #   user.valid?
    #   expect(user.errors[:password]).to include("")
    # end

  end

end
