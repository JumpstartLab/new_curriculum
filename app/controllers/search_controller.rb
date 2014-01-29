class SearchController < ApplicationController
  def search
    @static_pages = Search.static_pages(params[:search])
  end
end