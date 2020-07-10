require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

describe User do

  describe '#create' do

    it "ネームの入力が空かどうか" do
      user = build(:user, name: "")
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    it "Eメールの入力が空かどうか" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "パスワードの入力が空かどうか" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "Eメールは重複して登録されていないかどうか" do
      user = build(:user, email: "sample@sample.com" "sample@sample.com")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "パスワードは７文字以上かどうか" do
      user = build(:user, password: "123456")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end

  end

end
