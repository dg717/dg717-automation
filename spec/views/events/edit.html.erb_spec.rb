require 'rails_helper'

RSpec.describe "events/edit", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      :name => "MyString",
      :type => 1,
      :description => "MyText",
      :subtext => "MyText",
      :image => "MyString"
    ))
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(@event), "post" do

      assert_select "input#event_name[name=?]", "event[name]"

      assert_select "input#event_type[name=?]", "event[type]"

      assert_select "textarea#event_description[name=?]", "event[description]"

      assert_select "textarea#event_subtext[name=?]", "event[subtext]"

      assert_select "input#event_image[name=?]", "event[image]"
    end
  end
end
