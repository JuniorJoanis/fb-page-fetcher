class AddUniqFbuidToPageTable < ActiveRecord::Migration
  def change
    change_column :pages, :fbuid, :string, :uniq => true
  end
end
