FactoryBot.define do
  factory :sendaddress do
    s_firstname         {"あいう"}
    s_lastname          {"えお"}
    s_h_firstname       {"アイウ"}
    s_h_lastname        {"エオ"}
    zipcode             {"1234567"}
    prefectures         {"東京"}
    municipalitities    {"東京市"}
    streetaddress       {"1"}
  end
end
