FactoryBot.define do
  factory :entry do
    user
    title { Faker::Beer.name }
    body {
      Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 5)
    }
    tags { [create(:tag)] }
    published_at { Time.now }
  end
end