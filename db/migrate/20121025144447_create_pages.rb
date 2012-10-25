class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :fbuid
      t.string :name
      t.text :image_url

      t.timestamps
    end
  end
end
