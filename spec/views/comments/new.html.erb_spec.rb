require 'spec_helper'

describe "comments/new" do
  before(:each) do
    assign(:comment, stub_model(Comment,
      :comment => "MyString",
      :user_id => 1,
      :comment_type => 1,
      :location_id => 1
    ).as_new_record)
  end

  it "renders new comment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => comments_path, :method => "post" do
      assert_select "input#comment_comment", :name => "comment[comment]"
      assert_select "input#comment_user_id", :name => "comment[user_id]"
      assert_select "input#comment_comment_type", :name => "comment[comment_type]"
      assert_select "input#comment_location_id", :name => "comment[location_id]"
    end
  end
end
