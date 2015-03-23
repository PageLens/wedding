require 'rails_helper'

RSpec.describe "reservations/show", type: :view do
  before(:each) do
    @reservation = assign(:reservation, Reservation.create!(
      :slug => "Slug"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Slug/)
  end
end
