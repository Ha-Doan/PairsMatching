class MatchesController < ApplicationController

  def index
    @matches = Match.all
  end

  def show
    @matches = Match.all
  end

  def new
    @match = Match.new
  end

  def edit
    @match = Match.find(params[:id])
  end

  def update
      @match = Match.find(params[:id])

      if @match.update_attributes(match_params)
         redirect_to @match
      else
         render 'edit'
      end
  end

  def create
    @match = Match.new(dinosaur_params)

    if @match.save
       redirect_to @match
    else
       render 'new'
    end
  end

  def destroy
    @match = Match.find(params[:id])

    @match.destroy

    redirect_to matches_path
  end


    private

  def dinosaur_params
    params.require(:match).permit(:date, :pairs)
  end

end
