# frozen_string_literal: true

# abilyty
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      ability_of_admin user
    else
      ability_of_client user
    end
    can %i[index show], Post
    can %i[index show], Comment
  end

  def ability_of_admin(user)
    can :manage, User
    can %i[create destroy], Post
    can %i[create destroy], Comment
    can %i[edit update destroy], Post, user_id: user.id
    can %i[edit update destroy], Comment, user_id: user.id
  end

  def ability_of_client(user)
    can %i[index show], User
    can %i[edit update], User, id: user.id
    can %i[create edit update destroy], Post, user_id: user.id
    can %i[create edit update destroy], Comment, user_id: user.id
  end
end
