FactoryBot.define do
  factory :post do
    date { Time.zone.today }
    rationale { "Some rationale" }
    user
  end

  factory :second_post, class: "Post" do
    date { Time.zone.yesterday }
    rationale { "Some more content" }
    user
  end
end