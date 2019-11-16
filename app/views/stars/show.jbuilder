json.count @entry.stars_count
if current_user && current_user != @entry_user
  json.submitPath entry_star_path(@entry)
end