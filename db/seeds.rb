tables = %w(users)

tables.each do |name|
  file = Rails.root.join('db', 'seeds', Rails.env, "#{name}.rb")
  if File.exists?(file)
    puts "Loading #{name} ..."
    load(file)
  end
end
