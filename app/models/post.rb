class Post < ActiveRecord::Base
  self.per_page = 10
  acts_as_taggable
  acts_as_votable
  markable_as :favorite

  belongs_to :user

  validates_presence_of :title, :user
  validates :links, :presence => true, :url => true

  AvailableTags = %w(Rails Ruby RoR Js Jquery Gems)

  after_create :send_mail

  def user_name
    self.user.name
  end

  def self.search(params)
    params[:q] ||= "%"
    query = "%"+params[:q].downcase+"%"
    @posts = Post.where("lower(title) like ? or lower(links) like ? or lower(description) like ?", query, query, query).paginate(:page => params[:page], :per_page => 30)
  end

  def send_mail
    Notifier.delay.email_notify(id)
  end
end
