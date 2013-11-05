class MileagesController < ApplicationController

  def create
    session[:mileage_params] = params[:mileage]
    calculate
  end

  def recreate
    calculate

    respond_to do |format|
      format.html do
        render action: :create
      end
    end
  end

  private

  def calculate
    @mileage = Mileage.new(session[:mileage_params])
    @mileage.calculate!
  end

end
