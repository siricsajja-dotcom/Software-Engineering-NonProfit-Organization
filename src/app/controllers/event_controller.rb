# app/controllers/events_controller.rb
class EventsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      render json: { message: "Event created" }
    end
  end