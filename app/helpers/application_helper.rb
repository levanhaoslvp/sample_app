# frozen_string_literal: true

module ApplicationHelper
  def full_title page_title = ""
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def gravatar_for user, options = {size: 80}
    size = options[:size]
    prov = session["provider"]
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    auth_avatar = current_user.providers.find_by(provider: prov).avatar
    gravatar_url = auth_avatar || "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
