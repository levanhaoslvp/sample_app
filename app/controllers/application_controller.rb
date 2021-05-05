# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionHelper
  def hello
    render html: 'hello, world!'
  end
end
