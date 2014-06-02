class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :solution, null: false
      t.string :field_name, null: false
      t.integer :field_index, null: false, default: 1
      t.string :text, null: false
      t.timestamps
    end
  end
end
