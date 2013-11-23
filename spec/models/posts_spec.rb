require 'spec_helper'

describe Post do
  context "Association" do
    it {should belong_to :user}
  end
end
