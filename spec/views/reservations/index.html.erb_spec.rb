require 'rails_helper'

RSpec.describe "reservations/index", type: :view do
  before(:each) do
    assign(:reservations, [
      Reservation.create!(
        :slug => "Slug"
      ),
      Reservation.create!(
        :slug => "Slug"
      )
    ])
  end

  it "renders a list of reservations" do
    render
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
  end
end
