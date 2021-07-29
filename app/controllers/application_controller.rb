# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionHelper
  protect_from_forgery with: :exception

  def self.render_with_signed_in_user user, *args
    ActionController::Renderer::RACK_KEY_TRANSLATION["warden"] ||= "warden"
    proxy = Warden::Proxy.new({}, Warden::Manager.new({})).tap do |i|
      i.set_user(user, scope: :user)
    end
    renderer = self.renderer.new("warden" => proxy)
    renderer.render(*args)
  end
end
