class Api::V1::SchedulesController < Api::V1::ApiController
  before_action :set_schedule, only: [:show, :update]

  def create
    @schedule = Schedule.new schedule_params

    if @schedule.save
      render json: { schedule_id: @schedule.id }
    else
      render json: { errors: @schedule.errors }
    end
  end

  def update
    if @schedule.update schedule_params
      render json: { schedule_id: @schedule.id }
    else
      render json: { errors: @schedule.errors }
    end
  end

  def show
  end

  private

  def schedule_params
    params.require(:schedule).permit(days_attributes: [ :id, :start, :finish, :weekday ])
  end

  def set_schedule
    @schedule = Schedule.find params[:id]
  end
end
