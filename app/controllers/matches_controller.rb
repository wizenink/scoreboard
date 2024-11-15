class MatchesController < ApplicationController

  http_basic_authenticate_with name: Rails.application.credentials.dig(:login, :username), password: Rails.application.credentials.dig(:login, :password), except: :prod_show

  def show
    @match = Match.find(params[:id])
  end

  def prod_show
    @match = Match.find(params[:id])
  end
  def index
    @matches = Match.all
  end

  def new
    @match = Match.new
  end

  def destroy
    @match = Match.find(params[:id])
    @match.destroy
    redirect_to matches_path
  end
  def create
    @match = Match.new(match_params)
    if @match.save
      redirect_to @match, notice: 'Match was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def increment_score
    @match = Match.find(params[:id])
    if params[:team] === "a"
      @match.increment!(:goals_team_a)
    elsif params[:team] === "b"
      @match.increment!(:goals_team_b)
    end
    @match.save
    puts @match.goals_team_a
    ActionCable.server.broadcast "match_#{@match.id}_channel", { goals_team_a: @match.goals_team_a, goals_team_b: @match.goals_team_b }
    head :ok
  end

  def decrement_score
    @match = Match.find(params[:id])
    if params[:team] === "a"
      if @match.goals_team_a > 0
        @match.decrement!(:goals_team_a)
      end
    elsif params[:team] === "b"
      if @match.goals_team_b > 0
        @match.decrement!(:goals_team_b)
      end
    end

    ActionCable.server.broadcast "match_#{@match.id}_channel", { goals_team_a: @match.goals_team_a, goals_team_b: @match.goals_team_b }
    head :ok
  end
  def edit
  end

  private
  def match_params
    params.require(:match).permit(:team_a, :team_b, :goals_team_a, :goals_team_b)
  end
end
