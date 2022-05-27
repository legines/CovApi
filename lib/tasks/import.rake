require 'csv'
require 'open-uri'

BASE_URL = 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/'
CONFIRMED = 'time_series_covid19_confirmed_global.csv'
DEATH = 'time_series_covid19_deaths_global.csv'
RECOVERED = 'time_series_covid19_recovered_global.csv'
ALL_URLS = [DEATH, RECOVERED, CONFIRMED]
namespace :import do
    desc "Import Covid Time Series"
    task deaths: :environment do
        ALL_URLS.each do |url|
            csv_text = URI.parse("#{BASE_URL}#{url}").read
            csv = CSV.parse(csv_text, headers: true)
            if url == 'time_series_covid19_deaths_global.csv'
                dates = csv.headers.reject { |header| ["Province/State", "Country/Region", "Lat", "Long"].include?(header) }
                csv.each do |row|
                    hashed = row.to_hash
                    c = Location.new
                    c.province_state = hashed['Province/State'] 
                    c.country = hashed['Country/Region']
                    c.latitude = hashed['Lat']
                    c.longitude = hashed['Long']
                    c.save
        
                    dates.each do |date|
                        o = Occurrence.new
                        o.date = DateTime.strptime(date, "%m/%d/%y")
                        o.deaths = hashed[date]
                        o.location_id = c.id
                        o.save
                    end
                end
            else
                csv.each do |row|
                    hashed = row.to_hash
                    country = Location.find_by(latitude: hashed['Lat'], longitude: hashed['Long'])
                    next unless country
                    if url == 'time_series_covid19_confirmed_global.csv'
                        country.occurrences.each do |land|
                            land.update(confirmed:  hashed[land['date'].strftime("%-m/%-d/%y")])
                            land.save
                        end
                    else
                        country.occurrences.each do |land|
                            land.update(recovered:  hashed[land['date'].strftime("%-m/%-d/%y")])
                            land.save
                        end
                    end
                end
            end
        end
    end
    task test: :environment do
        ALL_URLS.each do |url|
            csv_text = open("#{BASE_URL}#{url}") 
            csv = CSV.parse(csv_text, headers: true)
            csv.each do |row|
                hashed = row.to_hash
                country = Location.find_by(latitude: hashed['Lat'], longitude: hashed['Long'])
                next unless country
                next_day = country.occurrences.order('date').last.date.next_day(1).strftime("%-m/%-d/%y")
                if url == 'time_series_covid19_deaths_global.csv'
                    o = Occurrence.new(date: DateTime.strptime(next_day, "%m/%d/%y"), deaths: hashed[next_day], location_id: country.id)
                    o.save
                else
                    latest_occ = country.occurrences.last
                    if url == 'time_series_covid19_recovered_global.csv'
                        latest_occ.update(recovered: hashed[next_day])
                        latest_occ.save
                    else
                        latest_occ.update(confirmed: hashed[next_day])
                        latest_occ.save
                    end
                end
            end
        end
    end
end 

# 66 no res
# 150, 189-190, 211 213, 247  no res no con