class Mileage
  include ActiveModel::Model

  validates_presence_of :month_number, :minimum_cost, :start_city, :end_city, :km
  attr_accessor :month_number, :overall_cost, :km, :minimum_cost, :start_city, :end_city, :rows, :trip_name
  KM_PRICE = 0.8358

  def initialize options = {}
    self.rows = []
    self.overall_cost = 0.0
    self.km = options.fetch(:km, 46).to_i
    self.minimum_cost = options.fetch(:minimum_cost, nil).to_i
    self.start_city = options.fetch(:start_city, 'start city')
    self.end_city = options.fetch(:end_city, 'destintation city')
    self.trip_name = "#{start_city} - #{end_city} - #{start_city}"
    self.month_number = options.fetch(:month_number, Date.today.month).to_i
  end

  def calculate!
    next_month_number = month_number < 12 ? (month_number + 1) : 1
    first_day = Date.parse("2013/#{month_number}/01")
    last_day = Date.parse("2013/#{next_month_number}/01") - 1
    (first_day..last_day).to_a.reject!{ |d| d.saturday? || d.sunday? }.sample(days_to_calculate).sort.each do |date|
      if !date.saturday? && !date.sunday?
        self.rows << calculate_and_display_date(date)
        self.rows.flatten!
      end
    end
  end

  private

  def calculate_and_display_date(date)
    increment_overall_cost
    first_way = MileageRow.new(date, trip_name, km * 2, "work", KM_PRICE, cost_for_day, overall_cost )
  end

  def increment_overall_cost
    self.overall_cost += cost_for_day
  end

  def cost_for_day
    (km * KM_PRICE) * 2
  end

  def days_to_calculate
    (minimum_cost / KM_PRICE / km / 2).ceil
  end

end
