require 'rails_helper'

# RSpec.describe Personal, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

describe Personal do

  describe '#create_personal' do

    it "誕生日の入力が空かどうか" do
      personal = build(:personal, birthday: "")
      personal.valid?
      expect(personal.errors[:birthday]).to include("を入力してください")
    end

    it "ファーストネームの入力が空かどうか" do
      personal = build(:personal, firstname: "")
      personal.valid?
      expect(personal.errors[:firstname]).to include("を入力してください")
    end

    it "ラストネームの入力が空かどうか" do
      personal = build(:personal, lastname: "")
      personal.valid?
      expect(personal.errors[:lastname]).to include("を入力してください")
    end

    it "ファーストネームのフリガナの入力が空かどうか" do
      personal = build(:personal, h_firstname: "")
      personal.valid?
      expect(personal.errors[:h_firstname]).to include("を入力してください")
    end

    it "ラストネームのフリガナの入力が空かどうか" do
      personal = build(:personal, h_lastname: "")
      personal.valid?
      expect(personal.errors[:h_lastname]).to include("を入力してください")
    end

    it "ファーストネームの入力が全角かどうか" do
      personal = build(:personal, firstname: "sample")
      personal.valid?
      expect(personal.errors[:firstname]).to include("は不正な値です")
    end

    it "ラストネームの入力が全角かどうか" do
      personal = build(:personal, lastname: "sample")
      personal.valid?
      expect(personal.errors[:lastname]).to include("は不正な値です")
    end

    it "ファーストネームのフリガナの入力が全角カタカナかどうか" do
      personal = build(:personal, h_firstname: "さんぷる")
      personal.valid?
      expect(personal.errors[:h_firstname]).to include("は不正な値です")
    end

    it "ラストネームのフリガナの入力が全角カタカナかどうか" do
      personal = build(:personal, h_lastname: "さんぷる")
      personal.valid?
      expect(personal.errors[:h_lastname]).to include("は不正な値です")
    end

  end

end