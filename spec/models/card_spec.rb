require 'rails_helper'

describe Card do

  describe '#create_card' do

    it "customer_idが空かどうか" do
      card = build(:card, customer_id: "")
      card.valid?
      expect(card.errors[:customer_id]).to include("を入力してください")
    end

    it "card_idが空かどうか" do
      card = build(:card, card_id: "")
      card.valid?
      expect(card.errors[:card_id]).to include("を入力してください")
    end

  end

end