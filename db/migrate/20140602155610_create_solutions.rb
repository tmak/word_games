class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.references :mad_lib, null: false
      t.timestamps
    end
  end
end
