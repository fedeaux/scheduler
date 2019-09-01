class Api::V1::SchedulesController < Api::V1::ApiController
  def create
    if Schedule.create(schedule_params)
    else
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit(days_attributes: [ :id, :start, :finish, :weekday ])
  end
end
