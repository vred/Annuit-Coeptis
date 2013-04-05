require 'spec_helper'

describe "messages/edit" do
  before(:each) do
    @message = assign(:message, stub_model(Message,
      :message => "MyString",
      :senderID => 1,
      :recipientID => 1
    ))
  end

  it "renders the edit message form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => messages_path(@message), :method => "post" do
      assert_select "input#message_message", :name => "message[message]"
      assert_select "input#message_senderID", :name => "message[senderID]"
      assert_select "input#message_recipientID", :name => "message[recipientID]"
    end
  end
end
