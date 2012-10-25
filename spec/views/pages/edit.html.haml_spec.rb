require 'spec_helper'

describe "pages/edit" do
  before(:each) do
    @page = assign(:page, stub_model(Page,
      :fbuid => 1,
      :name => "MyString",
      :image_url => "MyText"
    ))
  end

  it "renders the edit page form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pages_path(@page), :method => "post" do
      assert_select "input#page_fbuid", :name => "page[fbuid]"
      assert_select "input#page_name", :name => "page[name]"
      assert_select "textarea#page_image_url", :name => "page[image_url]"
    end
  end
end
