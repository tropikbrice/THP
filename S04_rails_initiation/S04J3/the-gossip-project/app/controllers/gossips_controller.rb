class GossipsController < ApplicationController
	def index
		@gossips = Gossip.all
	end

	def new
		@gossip = Gossip.new
		# @gossip.anonymous_author = "type your anonymous user"
		# @gossip.content = "write your fucking gossip!"
		# @gossip.save
		# @gossip.anonymous_author = 
	end

	def show
		@gossip = Gossip.find(params[:id])
		puts "id = #{@gossip.id} "
		# puts "your gossip : #{@gossip}"
	end

	def edit
		@gossip = Gossip.find(params[:id])
	end

	def update
		@gossip = Gossip.find(params[:id])

		if @gossip.update(gossip_params)
			redirect_to @gossip
		else
			render "Edit"
		end
		
	end

	def destroy
		@gossip = Gossip.find(params[:id])
		@gossip.destroy
		redirect_to gossips_path
	end

	def create
		@gossip = Gossip.new(gossip_params)
		if @gossip.save
			redirect_to @gossip
		else
			render "new"
		end
	end

	private
		def gossip_params
			params.require(:gossip).permit(:anonymous_author, :content)
		end
end