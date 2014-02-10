class Search
  def self.pages(criteria)
    Page.search do
      fulltext(criteria) { boost_fields title: 10.0 }

      paginate page: 1, per_page: 50
    end.results
  end
end