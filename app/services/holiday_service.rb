require 'httparty'

class HolidayService
    def self.holidays_of_US
        response = HTTParty.get('https://date.nager.at/api/v3/NextPublicHolidays/US')

        body = response.body

        parsed = JSON.parse(body, symbolize_names: true)
    end
end
