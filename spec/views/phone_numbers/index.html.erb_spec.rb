require 'rails_helper'

RSpec.describe "phone_numbers/index", :type => :view do
  before(:each) do
    assign(:phone_numbers, [
      PhoneNumber.create!(
        :number => "Number",
        :contact_id => 1#,
        # :contact_type => "Person"
      ),
      PhoneNumber.create!(
        :number => "Number",
        :contact_id => 1#,
        # :contact_type => "Person"
      )
    ])
  end

  it "renders a list of phone_numbers" do
    render
    assert_select "tr>td", :text => "Number".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
