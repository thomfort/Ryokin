class AdvisorsController < ApplicationController
  respond_to :html, :xml, :json
  def index
    @advisors = Advisor.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @advisor }
    end
  end
  
  def show
    @advisor = Advisor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @advisor }
    end
  end
  
  def edit
    @advisor = Advisor.find(params[:id])
    
  end
  
  def new
    @advisor = Advisor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @advisor }
    end
  end
  
  def add_comment
    @advisor = Advisor.find(params[:commentable_id])
    body_comment = params[:comment]
    
    @comment = @advisor.comments.new( :title => "Title comment", :comment => body_comment, :user => current_user)
    
    if @comment.save
      respond_with do |format|
        format.html do
          if request.xhr?
            #redirect_to root_url
          else
            redirect_to root_url, :notice => "Comment added for #{@advisor.firstname}!"          
          end
        end
      end
    end
  end
  
  def create
    @advisor = Advisor.new(params[:advisor])
    
    respond_to do |format|
      if @advisor.save
        format.html { redirect_to(@advisor, :notice => 'Advisor was successfully created.') }
        format.xml  { render :xml => @advisor, :status => :created, :location => @advisor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @advisor.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @advisor = Advisor.find(params[:id])

    respond do |format|
      if @advisor.update_attributes(params[:rate])
        format.html { redirect_to(@advisor, :notice => 'Advisor was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @advisor.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @advisor = Advisor.find(params[:id])
    @advisor.destroy

    respond_to do |format|
      format.html { redirect_to(advisors_url) }
      format.xml  { head :ok }
    end
  end
end
