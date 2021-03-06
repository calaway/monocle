FactoryGirl.define do
  factory :company do
    category
    name              { Faker::Company.name }
    street_address    { Faker::Address.street_address + ", " +
                        Faker::Address.secondary_address }
    city_state_zip    { Faker::Address.city + ", " +
                        Faker::Address.state_abbr + " " +
                        Faker::Address.zip_code }
    phone             { Faker::PhoneNumber.phone_number }
    website           { Faker::Internet.url }
    headquarters      { Faker::Address.city + ", " +
                        Faker::Address.state_abbr }
    products_services { Faker::Hipster.paragraph }
    person_in_charge  { Faker::Name.name + ", " +
                        Faker::Name.title }
    city              { City.find_or_create_by(
                        name: city_state_zip.split[0...-2]
                        .join(" ").gsub(",", "")) }
    state             { State.find_or_create_by(
                        name: city_state_zip.split[-2]) }
    zip_code          { ZipCode.find_or_create_by(
                        zip_code: city_state_zip.split.last) }
  end

  factory :category do
    name { Faker::Commerce.department(2, true) }

    factory :category_with_companies do
      transient do
        companies_count 2
      end

      after(:create) do |category, evaluator|
        create_list(:company, evaluator.companies_count, category: category)
      end
    end
  end
end
