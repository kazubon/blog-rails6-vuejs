json.entries do
  json.array! @form.entries do |entry|
    json.id entry.id
    json.title entry.title
    json.path entry_path(entry)
    json.user_name entry.user.name
    json.user_path user_entries_path(entry.user)
    json.draft entry.draft?
    json.published_at entry.published_at.try(:strftime, '%Y-%m-%d %H:%M')
    json.stars_count entry.stars_count
    json.tags do
      json.array! entry.tags do |tag|
        json.id tag.id
        json.name tag.name
        json.tag_path(
          @user ? user_entries_path(@user, q: { tag: tag.name }) :
            entries_path(q: { tag: tag.name })
        )
      end
    end
  end
end
json.entries_count @form.entries_count
