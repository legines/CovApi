class Location < ApplicationRecord
    has_many :occurrences

    def as_json(options = {})
        {
            id: id,
            province_state: province_state,
            country_region: country,
            last_updated: updated_at,
            coordinates: {
                latitude: latitude,
                longitude: longitude
            },
            latest: {
                confirmed: occurrences&.order("created_at").last.confirmed,
                deaths: occurrences&.order("created_at").last.deaths,
                recovered: occurrences&.order("created_at").last.recovered
            }
        }
    end

    def time_series(key)
        data = {}
        occurrences.each do |occ|
            data[occ.date] = occ[key]
        end
        data
    end
end
