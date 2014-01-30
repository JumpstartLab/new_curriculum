class Page < ActiveRecord::Base
  searchable do
    string :filename
    string :title
    string :slug
    text   :content
  end
end