class Answer < ActiveRecord::Base
  attr_accessible :solution_id, :field_type, :field_description, :field_index, :text

  belongs_to :solution

  def self.from_field(field, attrs={})
    new(attrs.merge(field_type: field.type, field_description: field.description, field_index: field.index))
  end

  def field
    @field ||= Field.new(type: field_type, description: field_description, index: field_index)
  end

  def field_name
    field.name
  end

  def field_label
    field.label
  end

  def as_json(options={})
    super(options.merge(methods: [:field_name, :field_label]))
  end
end
