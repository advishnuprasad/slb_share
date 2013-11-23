class Post < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title, :description, :user
  AvailableTags = %w(Rails Ruby RoR Js Jquery Gems)
  def user_name
    self.user.name
  end
end
