class Post < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title, :description, :user
  def user_name
    self.user.name
  end
end
