class StaticPage < ActiveRecord::Base
  searchable do
    string :filename
    string :title
    text   :content
  end
end