class StaticPage < ActiveRecord::Base
  searchable do
    string :title do |title|
      FormatterService.remove_file_extension(title)
    end

    text :content
  end
end