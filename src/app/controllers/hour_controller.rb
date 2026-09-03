# app/controllers/hours_controller.rb
# app/controllers/hours_controller.rb
class HoursController < ApplicationController
    before_action :authenticate_user!
  
    # Check in: creates a new volunteer hour record with 0 hours
    def checkin
      vh = VolunteerHour.create!(user: current_user, event_date: Time.current, hours: 0)
      render json: { message: "Checkin successful", id: vh.id }
    end
  
    # Check out: updates the most recent volunteer hour with actual hours
    def checkout
      vh = current_user.volunteer_hours.order(event_date: :desc).first
      if vh
        vh.update(hours: ((Time.current - vh.event_date) / 3600.0).round(2)) # hours in decimal
        render json: { message: "Checkout successful", hours: vh.hours }
      else
        render json: { message: "No checkin found", status: :unprocessable_entity }
      end
    end
  
    # Approve (example, can leave simple)
    def approve
      render json: { message: "Approval successful" }
    end
  end