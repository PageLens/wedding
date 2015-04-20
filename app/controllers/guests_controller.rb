class GuestsController < ApplicationController
  http_basic_authenticate_with name: "admin", password: Rails.application.secrets.auth_password

  def index
    @guests = Guest.order(:reservation_id).all
  end
end
