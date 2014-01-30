class ChangeStaticPagesTableNameToPages < ActiveRecord::Migration
  def change
    rename_table :static_pages, :pages
  end
end
