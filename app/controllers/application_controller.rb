class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV["SIDEKIQ_USERNAME"], password: ENV["SIDEKIQ_PASSWORD"]
  protect_from_forgery with: :exception
end
