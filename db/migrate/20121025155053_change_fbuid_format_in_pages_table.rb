class ChangeFbuidFormatInPagesTable < ActiveRecord::Migration
  def change
     change_column :pages, :fbuid, :string
  end
end
