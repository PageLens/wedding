class HomeController < ApplicationController
  def index
  end

  def events
    respond_to do |format|
      format.html
      format.ics {render text: Event.wedding.to_ical}
    end
  end

  def about_us

  end
end
