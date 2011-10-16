class TipsController < ApplicationController
	
	def index
		@tips = Tip.all

		respond_to do |format|
			format.html # index.html.erb
			format.xml	{ render :xml => @tips }
		end
	end
	
	def new
		@tip = Tip.new

		respond_to do |format|
			format.html # new.html.erb
			format.xml	{ render :xml => @tip }
		end
	end
	
	def create
		@tip = Tip.new(params[:tip])
		
		respond_to do |format|
			if @tip.save
				format.html { redirect_to(@tip, :notice => 'Tip was successfully created.') }
				format.xml	{ render :xml => @tip, :status => :created, :location => @tip }
			else
				format.html { render :action => "new" }
				format.xml	{ render :xml => @tip.errors, :status => :unprocessable_entity }
			end
		end
	end
	
	def show
		@tip = Tip.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.xml	{ render :xml => @tip }
		end
	end

	
end
