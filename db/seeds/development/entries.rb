Tagging.delete_all
Entry.delete_all

users = User.all
tags = Tag.all
tag_count = Tag.count

Faker::Config.locale = :en

100.times do
  Entry.create!(
    user: users.sample,
    title: Faker::Beer.name,
    body: Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 5),
    tags: tags.sample(rand(tag_count + 1)),
    published_at: rand(2400).hours.ago
  )
end
