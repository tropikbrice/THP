require 'pry'

class MapsController < ApplicationController
	def index
		@map = Map.new

		return unless param_maps[:map] && param_maps[:map][:latitude] && param_maps[:map][:longitude] && param_maps[:map][:message]
		@map.latitude = param_maps[:map][:latitude]
		@map.longitude = param_maps[:map][:longitude]
		@map.message = param_maps[:map][:message]
	end

	def default_map
		@map.latitude = 45 # default value
		@map.longitude = 0 # default value
		@map.message = 'default marker' # default value
	end

	def param_maps
		params.permit(map: [:latitude, :longitude, :message])
	end
end

