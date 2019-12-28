json.entry do
  json.id @entry.id
  json.title @entry.title
  json.body @entry.body
  json.published_at (@entry.published_at || Time.zone.now).strftime('%Y-%m-%d %H:%M')
  json.draft @entry.draft
  json.tags do
    json.array! @entry.tags do |tag|
      json.id tag.id
      json.name tag.name
      json.path entries_path(tag: tag.name)
    end
  end
  unless @entry.new_record?
    json.user_name @entry.user.name
    json.user_path user_entries_path(@entry.user)
    json.star_count @entry.stars_count
  end
  json.editable @entry.editable_by?(current_user)
  json.starrable @entry.starrable_by?(current_user)
end
