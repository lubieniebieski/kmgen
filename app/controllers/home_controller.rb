class HomeController < ApplicationController

  def index
    @mileage = Mileage.new(session[:mileage_params] || {})
  end

  def about

  end

end
