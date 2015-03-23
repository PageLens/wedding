require 'rails_helper'

RSpec.describe "reservations/new", type: :view do
  before(:each) do
    assign(:reservation, Reservation.new(
      :slug => "MyString"
    ))
  end

  it "renders new reservation form" do
    render

    assert_select "form[action=?][method=?]", reservations_path, "post" do

      assert_select "input#reservation_slug[name=?]", "reservation[slug]"
    end
  end
end
