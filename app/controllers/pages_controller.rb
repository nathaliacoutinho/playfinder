class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :show, :search]

  def home
    @places = Place.all.limit(3)
    @events = Event.all.limit(4)

    if user_signed_in?
      @selected_events = []
      current_user.bucket_list.list_events.each do |list_event|
        @selected_events << list_event.event
      end
    end
  end


  def search
    @query = params[:query] || ""
    @places = Place.all
    @events = Event.all.limit(8)

    if !@query.empty?
      @places = Place.full_search(@query)
      @events = Event.full_search(@query)
    end

    @datepick = params[:datepick]
    if @datepick && !params[:datepick].empty?
      @events = @events.datepick(Date.parse(@datepick))
    end

    @event = (@event = params[:events]) && !@event.empty?
    if @event
      @places = Place.none
    end

    @playground = params[:playground]
    if @playground == "true"
      @places = @places.category("playground")
      @events = Event.none
    end

    @age_0_2 = params[:age_0_2]
    @age_3_5 = params[:age_3_5]
    @age_0_5 = params[:age_0_5]
    if @age_0_2 && @age_3_5 && !@age_0_2.empty? && @age_3_5.empty?
      @places = @places.age_0_2
      # @events = Event.full_search(params[:query])
    elsif @age_0_2 && @age_3_5 && !@age_3_5.empty? && @age_0_2.empty?
      @places = @places.age_3_5
    elsif @age_0_2 && @age_3_5 && !@age_3_5.empty? && !@age_0_2.empty?
      @places = @places.age_0_5
    end


    @all_ages = (@all_ages = params[:all_ages]) && !@all_ages.empty?
    if @all_ages
      @events = Event.all
    end


    if user_signed_in?
      @selected_events = []
      @selected_places = []
      current_user.bucket_list.list_events.each do |list_event|
      @selected_events << list_event.event
    end
      current_user.bucket_list.list_places.each do |list_place|
      @selected_places << list_place.place
    end
  end
  end
end
  # def filter
  # @events = Event.where(nil) # creates an anonymous scope
  #  @events = @events.title(params[:title]) if params[:title].present?
  #  @events = @events.description(params[:description]) if params[:description].present?
  #  @events = @events.start_date(params[:start_date]) if params[:start_date].present?





#   def filtering_params
# params.slice(:title, :description, :start_date)
#   end

# end
