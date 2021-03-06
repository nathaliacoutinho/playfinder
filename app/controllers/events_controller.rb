class EventsController < ApplicationController

  def index

    if params[:query].present?
      @events = Event.full_search(params[:query])
    else
      @events = Event.all
    end
    @markers = @events.where.not(latitude: nil, longitude: nil).map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        # infoWindow: { content: render_to_string(partial: "../views/events/map_box.html.erb", locals: { event: event}) }

      }
    end
  end

  def show
    @bucketlist = BucketList.where(user_id: current_user.id)
    @event = Event.find(params[:id])
    @list_event = ListEvent.new

    @markers =
      [{
        lat: @event.latitude,
        lng: @event.longitude,
        # infoWindow: { content: render_to_string(partial: "../views/places/map_box.html.erb", locals: { place: place }) }
      }]
  end

  private

  def set_events
    @event = Event.find(params[:event_id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :start_time, :start_date, :end_time)
  end
end


# address = event.place.address

