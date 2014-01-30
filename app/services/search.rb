class Search
  def self.pages(criteria)
    Page.search do
      fulltext(criteria) { boost_fields title: 2.0 }

      order_by :title, :desc
      paginate page: 1, per_page: 50
    end.results
  end
end