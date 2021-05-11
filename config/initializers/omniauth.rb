# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :facebook, '176479037685855', 'b9a7c5b16d728f519af59ecbd35054ec', scope: 'email'
  # Ex:- scope :active, -> {where(:active => true)}
  provider :google_oauth2, '774274938155-tee4v9q877ff51jq3ro34nmnpaea6ptn.apps.googleusercontent.com',
           'AOWpPM-UDfTqB7I7s3C8f8fR', scope: 'email'
end
