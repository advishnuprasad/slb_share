class Notifier < ActionMailer::Base
  default from: "advishnuprasad@gmail.com"

  def notify_email(post_id)
    @post = Post.find(post_id)
    mail(to: User.pluck(:email).uniq - [@post.user.email], subject: "New link posted in SLbShare")
  end
end
