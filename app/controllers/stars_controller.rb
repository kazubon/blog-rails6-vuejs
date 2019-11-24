class StarsController < ApplicationController
  before_action :require_login

  def update
    entry = Entry.find(params[:entry_id])
    count = Star.put(current_user, entry)
    render json: { count: count }
  end
end
