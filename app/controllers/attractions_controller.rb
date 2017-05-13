class AttractionsController < ApplicationController
  before_action :find_attraction, only: %i[show edit update]

  def index
    @attractions = Attraction.all
  end

  def show
  end

  def new
    @attraction = Attraction.new
  end

  def create
    # raise params.inspect
    @attraction = Attraction.new(attraction_params)
    if current_user.admin && @attraction.save
      redirect_to @attraction
    else
      render 'new'
    end
  end

  def ride
    r = Ride.new(attraction_id: params[:id], user_id: current_user.id)
    if flash[:message] = r.take_ride
      redirect_to current_user
    else
      render show
    end
  end

  def edit
  end

  def update
    if current_user.admin && @attraction.update(attraction_params)
      redirect_to @attraction
    else
      render 'edit'
    end
  end

  private

  def attraction_params
    params.require(:attraction).permit(:name, :min_height, :happiness_rating, :nausea_rating, :tickets)
  end

  def find_attraction
    @attraction = Attraction.find(params[:id])
  end
end
