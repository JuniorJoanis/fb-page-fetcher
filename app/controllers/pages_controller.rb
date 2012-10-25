class PagesController < ApplicationController
  before_filter :register_fb_page, :only => [:search] 
  
  # POST /search.js
  # POST /search.json
  
  def search
    @pages = Page.all
    
    respond_to do |format|
      format.html # show.html.erb
      format.js
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
