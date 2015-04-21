require 'csv'

class GuestsController < ApplicationController
  http_basic_authenticate_with name: "admin", password: Rails.application.secrets.auth_password

  def index
    @guests = Guest.order(:reservation_id).all

    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"guests.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end
end
