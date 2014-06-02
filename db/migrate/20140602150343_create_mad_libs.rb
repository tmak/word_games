class CreateMadLibs < ActiveRecord::Migration
  def change
    create_table :mad_libs do |t|
      t.text :text, null: false
      t.timestamps
    end
  end
end
