require 'rails_helper'

def schedule_day_errors(params)
  schedule_day = Day.new(params)
  schedule_day.validate
  schedule_day.errors
end

RSpec.describe Day, type: :model do
  describe 'validations' do
    context 'start and finish' do
      %i[start finish].each do |time|
        it "does not allow #{time} in wrong formats" do
          expect(schedule_day_errors("#{time}": 'aaa')[time]).not_to be_empty
          expect(schedule_day_errors("#{time}": '1200')[time]).not_to be_empty
          expect(schedule_day_errors("#{time}": '99:00')[time]).not_to be_empty
          expect(schedule_day_errors("#{time}": '12:77')[time]).not_to be_empty
          expect(schedule_day_errors("#{time}": '24:50')[time]).not_to be_empty
          expect(schedule_day_errors("#{time}": '24:00')[time]).not_to be_empty
        end

        it "allows #{time} in the right formats or empty" do
          expect(schedule_day_errors("#{time}": '12:30')[time]).to be_empty
          expect(schedule_day_errors("#{time}": '23:59')[time]).to be_empty
          expect(schedule_day_errors("#{time}": '4:15')[time]).to be_empty
          expect(schedule_day_errors("#{time}": '')[time]).to be_empty
          expect(schedule_day_errors("#{time}": nil)[time]).to be_empty
        end
      end
    end

    context 'weekday' do
      it 'does not allow weekday outside the range' do
        expect(schedule_day_errors(weekday: -1)[:weekday]).not_to be_empty
        expect(schedule_day_errors(weekday: 15)[:weekday]).not_to be_empty
        expect(schedule_day_errors(weekday: 47)[:weekday]).not_to be_empty
      end

      [0..6].each do |weekday|
        it 'allow weekday inside the range' do
          expect(schedule_day_errors(weekday: weekday)[:weekday]).not_to be_empty
        end
      end
    end

    # ... others
  end
end
