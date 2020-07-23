FactoryBot.define do
  factory :sendaddress do
    s_firstname         {"あいう"}
    s_lastname          {"えお"}
    s_h_firstname       {"アイウ"}
    s_h_lastname        {"エオ"}
    zipcode             {"1234567"}
    prefectures         {"東京都"}
    municipalitities    {"千代田区"}
    streetaddress       {"丸の内"}
  end
end
