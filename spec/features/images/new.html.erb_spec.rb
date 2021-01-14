require 'rails_helper'

RSpec.describe "images/new", type: :view do
  before(:each) do
    assign(:image, Image.new(
      title: "MyString",
      body: "MyText"
    ))
  end

  it "renders new image form" do
    render

    assert_select "form[action=?][method=?]", images_path, "image" do

      assert_select "input[name=?]", "image[title]"

      assert_select "textarea[name=?]", "image[body]"
    end
  end
end
