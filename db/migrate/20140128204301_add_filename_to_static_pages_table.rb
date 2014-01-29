class AddFilenameToStaticPagesTable < ActiveRecord::Migration
  def change
    add_column :static_pages, :filename, :string
  end
end