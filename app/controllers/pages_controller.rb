class PagesController < ApplicationController
  def show
    @page = StaticPage.find_by(slug: params[:page_slug])
  end
end