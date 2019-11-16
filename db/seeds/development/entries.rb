Entry.delete_all

users = User.all
tags = Tag.all
tag_count = Tag.count

Faker::Config.locale = :en

100.times do
  entry = Entry.create!(
    user: users.sample,
    title: Faker::Beer.name,
    body: Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 5),
    tags: tags.sample(rand(tag_count + 1)),
    published_at: rand(2400).hours.ago
  )
  (users - [entry.user]).sample(rand(users.size)).each do |user|
    Star.create!(entry: entry, user: user)
  end
end
