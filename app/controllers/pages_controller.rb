class PagesController < ApplicationController
  before_filter :register_fb_page, :only => [:search] 
  
  # POST /search.js
  # POST /search.json
  
  def search
    @pages = Page.all
    
    respond_to do |format|
      format.js
      format.json { render json: @pages }
    end
  end
  
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find(params[:id])
    @feed = @page.feed
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/new.json
  def new
    @page = Page.new

    respond_to do |format|
      format.json { render json: @page }
    end
  end

  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.json { render json: @page, status: :created, location: @page }
      else
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.json { head :no_content }
      else
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
  
  private 
    def register_fb_page
      return if params[:fbuid].nil?
      @pagefbuid = params[:fbuid]
      @page = FbGraph::Page.fetch(@pagefbuid.to_i)
      if @page 
         @page = Page.create!({:name => @page.name, :image_url => @page.picture, :fbuid => @page.identifier})
      end
    end
end
