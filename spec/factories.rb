
FactoryGirl.define do
  factory :mad_lib do
    text "{field} - That's a {field, ending in -ing} - {field}"
  end

  factory :solution do
    mad_lib
  end
end