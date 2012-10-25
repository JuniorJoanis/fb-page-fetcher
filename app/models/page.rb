class Page < ActiveRecord::Base
  default_scope order("created_at DESC")
  attr_accessible :fbuid, :image_url, :name
  
  def feed(limit = 10)
     FbGraph::Page.fetch(self.fbuid, :access_token => FbPageFetcher::Application::FB_TOKEN).feed.take(limit)
  end
end
