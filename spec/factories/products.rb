FactoryBot.define do

  factory :product do
    name                  {"Faker::Lorem.characters(16)"}
    price                 {1000}
    category_id              {1}
    description           {"setumei"}
    brand                 {"viton"}
    size_id               {1}
    status_id             {2}
    shipfee_id            {2}
    shipregion_id         {1}
    estshipdate_id        {1}
    seller_id             {1}
    after(:build) do |product|
      product.images << build(:image, product: product)
    end
  end
end