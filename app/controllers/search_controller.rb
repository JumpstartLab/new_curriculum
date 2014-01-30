class SearchController < ApplicationController
  def search
    @pages = Search.pages(params[:search])
  end
end