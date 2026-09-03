class HistoryController < ApplicationController
    before_action :authenticate_user!

    def filter
        user = current_user
        unless user
        return render json: { error: "User not logged in" }, status: :unauthorized
        end

        range = params[:range]

        records = get_filtered_records(user.id, range)
        total_hours = calculate_total(records)

        render json: {
        records: records.as_json(only: [:id, :event_date, :hours]),
        totalHours: total_hours
        }
    end

    private

    def get_filtered_records(user_id, range)
        base = VolunteerHour.where(user_id: user_id)

        case range
        when "month"
        base = base.where("event_date >= ?", 1.month.ago)
        when "year"
        base = base.where("event_date >= ?", 1.year.ago)
        else
        # all or invalid: no filter
        base = base
        end

        base.order(event_date: :desc)
    end

    def calculate_total(records)
        records.sum(:hours)
    end
end