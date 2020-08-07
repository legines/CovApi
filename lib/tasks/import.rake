require 'csv'
require 'open-uri'

BASE_URL = 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/'
CONFIRMED = 'time_series_covid19_confirmed_global.csv'
DEATH = 'time_series_covid19_deaths_global.csv'
RECOVERED = 'time_series_covid19_recovered_global.csv'
REFERENCE = 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/UID_ISO_FIPS_LookUp_Table.csv'

namespace :import do
    desc "Import Covid Time Series Confirmed"
    task confirms: :environment do
        csv_text = open("#{BASE_URL}#{CONFIRMED}")
        csv = CSV.parse(csv_text, headers: true)
        csv.each do |row|
            hashed = row.to_hash
           t = ConfirmedLocation.new
           t.province_state = row.to_hash['Province/State'] 
           t.country_region = row.to_hash['Country/Region']
           t.latitude = row.to_hash['Lat']
           t.longitude = row.to_hash['Long']
           t.date = hashed.except("Province/State", "Country/Region", "Lat", "Long")
           t.save
        end
    end
end