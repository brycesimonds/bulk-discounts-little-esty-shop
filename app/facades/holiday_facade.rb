class HolidayFacade
    def self.holidays
        parsed = HolidayService.holidays_of_US
        us_holidays = parsed.first(3).map do |data|
            Holiday.new(data)
        end
    end
end
