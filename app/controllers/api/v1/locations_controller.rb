class Api::V1::LocationsController < ApplicationController
    
    def index
        @countries = Location.offset(1).all
        render json: @countries
    end

    def show
        @country = Location.find(params[:id])
        render json: @country
    end

    def latest
        @country = Location.find(params[:id])
        render json: { latest: @country.as_json[:latest] }
    end

    def confirmed
        @country = Location.find(params[:id])
        time_series_data = @country.time_series('confirmed')
        render json: time_series_data 
    end

    def recovered
        @country = Location.find(params[:id])
        time_series_data = @country.time_series('recovered')
        render json: time_series_data 
    end

    def deaths
        @country = Location.find(params[:id])
        time_series_data = @country.time_series('deaths')
        render json: time_series_data 
    end
end