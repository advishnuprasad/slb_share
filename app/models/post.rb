class Post < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user
  validates_presence_of :title, :description, :user
  AvailableTags = %w(Rails Ruby RoR Js Jquery Gems)
  def user_name
    self.user.name
  end
end
