require 'csv'
require 'open-uri'

BASE_URL = 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/'
CONFIRMED = 'time_series_covid19_confirmed_global.csv'
DEATH = 'time_series_covid19_deaths_global.csv'
RECOVERED = 'time_series_covid19_recovered_global.csv'
namespace :import do
    desc "Import Covid Time Series Confirmed"
    task confirms: :environment do
        csv_text = open("#{BASE_URL}#{CONFIRMED}")
        csv = CSV.parse(csv_text, headers: true)
        dates = csv.headers.reject { |header| ["Province/State", "Country/Region", "Lat", "Long"].include?(header) }
        csv.each do |row|
           hashed = row.to_hash
           c = Country.new
           c.province_state = hashed['Province/State'] 
           c.country_region = hashed['Country/Region']
           c.latitude = hashed['Lat']
           c.longitude = hashed['Long']
           c.save

           dates.each do |date|
                o = Occurrence.new
                o.date = date
                o.confirmed = hashed[date]
                o.country_id = c.id
                o.save
            end
        end
    end

    task deaths: :environment do
        csv_text = open("#{BASE_URL}#{DEATH}")
        csv = CSV.parse(csv_text, headers: true)
        csv.each do |row|
            hashed = row.to_hash
            country = Country.find_by(latitude: hashed['Lat'], longitude: hashed['Long'])
            country.occurrences.each do |land|
                land.update(deaths:  hashed[land['date']])
                land.save
            end
        end
    end

    task recovered: :environment do
        csv_text = open("#{BASE_URL}#{RECOVERED}")
        csv = CSV.parse(csv_text, headers: true)
        csv.each do |row|
            hashed = row.to_hash
            country = Country.find_by(latitude: hashed['Lat'], longitude: hashed['Long'])
            next unless country
            country.occurrences.each do |land|
                land.update(recovered:  hashed[land['date']])
                land.save
            end
        end
    end
end 