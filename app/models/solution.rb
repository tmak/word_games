class Solution < ActiveRecord::Base
  belongs_to :mad_lib

  has_many :answers

  def fill_field(label, options)
    field = Field.from_label(label)
    text = options.fetch(:with)
    answers.create(field_name: field.name, field_index: field.index, text: text)
  end

  def resolve
    mad_lib.resolve do |field_name, field_index|
      answers.where(field_name: field_name, field_index: field_index).first.text
    end
  end
end
