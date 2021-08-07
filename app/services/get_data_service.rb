class GetDataService
  def initialize user
    @user = user
  end

  def post_a_month
    user.posts.a_month_ago
  end

  def follower_a_month
    User.follower_a_month_ago(user)
  end

  def following_a_month
    User.following_a_month_ago(user)
  end

  private
  attr_reader :user
end
