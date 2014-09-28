class RolesController < ApplicationController
  helper_method :sort_column, :sort_direction

# Technically these are statistics about a play
# So this would be most logically contained in the
# Plays#show action.
# This would be a good thing to have if you were
# showing a role across multiple plays
# (e.g., an app answering the question "how many
# plays did Julius Caesar appear in?")
  def index
    @play = Play.find(params[:play_id])
    # Prefer to build strings with "#{blah} #{foo}" syntax. It will do more coercion for you.
    @roles = @play.roles.paginate(page: params[:page], per_page: 10).order(sort_column + " " + sort_direction)
  end

  private

  def sort_column
    Role.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
