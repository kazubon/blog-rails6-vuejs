json.entry do
  json.title @entry.title
  json.body @entry.body
  json.published_at (@entry.published_at || Time.zone.now).strftime('%Y-%m-%d %H:%M')
  json.draft @entry.draft
  json.tags do
    json.array! @entry.tags do |tag|
      json.name tag.name
    end
  end
end