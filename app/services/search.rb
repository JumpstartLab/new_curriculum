class Search
  def self.static_pages(criteria)
    StaticPage.search do
      fulltext(criteria) { boost_fields title: 2.0 }

      order_by :title, :desc
      paginate page: 1, per_page: 50
    end.results
  end
end