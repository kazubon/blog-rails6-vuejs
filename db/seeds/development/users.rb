Entry.delete_all
User.delete_all

User.create!(
  email: 'alice@example.com',
  name: 'Alice',
  password: 'password'
)

User.create!(
  email: 'bob@example.com',
  name: 'Bob',
  password: 'password'
)

User.create!(
  email: 'carol@example.com',
  name: 'Carol',
  password: 'password'
)

User.create!(
  email: 'dave@example.com',
  name: 'Dave',
  password: 'password'
)