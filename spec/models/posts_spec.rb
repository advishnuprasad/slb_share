require 'spec_helper'

describe Post do
  context "Association" do
    it { should belong_to :user }
  end

  context "Validation" do
    subject { FactoryGirl.create(:post) }
    it { should validate_presence_of :user }
    it { should validate_presence_of :links }
    it { should validate_presence_of :title }
  end

  describe "#user_name" do
    it "should return user name" do
      user = FactoryGirl.create(:user)
      post = FactoryGirl.create(:post, :user => user)
      post.user_name.should == user.email
    end
  end

  describe ".search" do
    it "should return search results based on the query" do
      post_1 = FactoryGirl.create(:post, :title => "Title1")
      post_2 = FactoryGirl.create(:post, :title => "Title2", :links => "http://prabha.com")
      post_3 = FactoryGirl.create(:post, :title => "Title3", :links => "http://prabha.com")
      Post.search({:q => "Title3"}).count.should == 1
      Post.search({:q => "prabha"}).count.should == 2
    end
  end
end
