# frozen_string_literal: true

require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test 'layout links' do
    get root_path
    #    assert_template 'static_p_age/home'
    assert_select 'a[href=?]', home_path
    #    assert_select "a[href=?]", help_path
    #    assert_select "a[href=?]", about_path
    #    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select 'title', full_title('Contact')
  end
end
