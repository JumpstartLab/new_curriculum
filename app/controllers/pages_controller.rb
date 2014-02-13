class PagesController < ApplicationController
  before_action :authenticate_user

  def show
    @page = Page.find_by(slug: params[:page_slug])
  end

  def index
    @pages = Page.all
  end
end