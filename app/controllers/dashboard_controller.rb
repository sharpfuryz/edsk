class DashboardController < ApplicationController
	before_filter :authenticate_user!
	def index
	@nodes = current_user.nodes
	end
end
