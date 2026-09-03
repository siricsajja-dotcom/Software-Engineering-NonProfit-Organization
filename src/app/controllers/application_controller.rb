class ApplicationController < ActionController::Base
  # If someone tried to pretend to be someone else, an error occurs for them
  before_action :authenticate_user!
end