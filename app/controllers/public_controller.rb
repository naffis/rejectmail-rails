class PublicController < ApplicationController
  
  def index
  end
  
  def view
    @email_name = params["email"]["name"].strip
    @email_pages, @emails = paginate :emails, 
      :conditions => ["name = ?", @email_name],
      :per_page => 10
  end
  
end