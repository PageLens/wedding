require 'rails_helper'

RSpec.describe "reservations/edit", type: :view do
  before(:each) do
    @reservation = assign(:reservation, Reservation.create!(
      :slug => "MyString"
    ))
  end

  it "renders the edit reservation form" do
    render

    assert_select "form[action=?][method=?]", reservation_path(@reservation), "post" do

      assert_select "input#reservation_slug[name=?]", "reservation[slug]"
    end
  end
end
