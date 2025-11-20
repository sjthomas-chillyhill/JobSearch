class Application < ApplicationRecord
  belongs_to :business

    enum :status, { Applied: 0, Interviewing: 1, Rejected: 2 }, default: :Applied


    def applied_this_week
      @applied_this_week = Application.where(appliedOn: 1.week.ago..Date.today)
    end
end
