User.find_or_create_by!(email: 'alice@example.com') do |u|
  u.assign_attributes(
    name: 'Alice',
    password: 'password'
  )
end

User.find_or_create_by!(email: 'bob@example.com') do |u|
  u.assign_attributes(
    name: 'Bob',
    password: 'password'
  )
end

User.find_or_create_by!(email: 'carol@example.com') do |u|
  u.assign_attributes(
    name: 'Carol',
    password: 'password'
  )
end
