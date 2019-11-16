module ApplicationHelper
  def star_path(entry)
    if current_user && current_user != entry.user
      entry_star_path(entry)
    else
      nil
    end
  end
end
