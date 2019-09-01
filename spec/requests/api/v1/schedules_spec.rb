require 'rails_helper'

def day_attributes(params)
  params[:start] ||= '12:00'
  params[:finish] ||= '17:00'
end

RSpec.describe 'Schedules', type: :request do
  include Rails.application.routes.url_helpers

  describe 'create a schedule' do
    it 'creates a schedule' do
      expect {
        post api_v1_schedules_path, params: { schedule: { days_attributes: [0..6].map { |i| day_attributes(weekday: i) } }}
      }.to change { Schedule.count }
    end

    describe 'invalid attributes' do
      it 'invalid weekdays' do
        expect {
          post api_v1_schedules_path, params: { schedule: { days_attributes: [1..7].map { |i| day_attributes(weekday: i) } }}
        }.not_to change { Schedule.count }
      end
    end
  end
end
