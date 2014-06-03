class AddFieldTypeAndFieldDescription < ActiveRecord::Migration
  def up
    add_column :answers, :field_type, :string
    add_column :answers, :field_description, :string

    Answer.all.each do |answer|
      field_name_parts = (answer.field_name || "").split(',', 2)
      answer.update_attributes(field_type: field_name_parts.first, field_description: field_name_parts.count > 1 ? field_name_parts.second : nil)
    end

    remove_column :answers, :field_name, :string
  end

  def down
    add_column :answers, :string, :field_name

    Answer.all.each do |answer|
      field_name = answer.field_type
      field_name += ", #{answer.field_description}"
      answer.update(field_name: field_name)
    end

    remove_column :answers, :field_type, :string
    remove_column :answers, :field_description, :string
  end
end
