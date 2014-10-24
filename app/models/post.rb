class Post < ActiveRecord::Base
  serialize :images 

  self.per_page = 10
  
  acts_as_taggable
  markable_as :favorite

  belongs_to :user

  validates_presence_of :user
  validates :links, :presence => true, :url => true

  after_create :send_mail
  before_save :get_site_info

  def get_site_info
    data = Grabbit.url(links)
    if data
      self.title = data.title
      self.description = data.description
      self.images = data.images
    end
  end

  def user_name
    self.user.name
  end

  def self.search(params)
    params[:q] ||= "%"
    query = "%"+params[:q].downcase+"%"
    @posts = Post.where("lower(title) like ? or lower(links) like ? or lower(description) like ?", query, query, query).paginate(:page => params[:page], :per_page => 30)
  end

  def send_mail
    Notifier.delay.notify_email(id) if Rails.env.production?
  end
end
