class WomenController < ApplicationController
	before_action :set_woman, only: [:show, :update, :destroy]

	#GET /women
	def index 
		@women = Woman.all
		json_response(@women)
	end

	#POST /women
	def create
		@woman = Woman.create!(woman_params)
		json_response(@woman, :created)
	end

	#GET /women/:id
	def show
		json_response(@woman)
	end

	#PUT /women/:id
	def update
		@woman.update(woman_params)
		# head :no_content
		json_response(@woman)
	end

	#DELETE /women/:id
	def destroy
		@woman.destroy
		head :no_content
	end

	private
	def woman_params
		# whitelist params
		params.permit(:name, :bio, :image_src)
	end

	def set_woman
		@woman = Woman.find(params[:id])
	end

end
