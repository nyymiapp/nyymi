FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :user2, class: User do
    username "Pekka2"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :company do
    name "Kuopio Software"
    description "Rails-koodausta"
  end

  factory :open_job do
    name "developer"
    company
    description "Etsimme hyvää koodaria."
    expires (DateTime.now + 2.months)
  end
end