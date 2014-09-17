class RolesController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @play = Play.find(params[:play_id])
    @roles = Role.where(play: @play).paginate(page: params[:page], per_page: 10).order(sort_column + " " + sort_direction)
  end

  private

  def sort_column
    Role.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
