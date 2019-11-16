class StarsController < ApplicationController
  before_action :require_login

  def update
    @entry = Entry.find(params[:entry_id])
    count = @entry.put_star(current_user)
    render json: { count: count }
  end
end
