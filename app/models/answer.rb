class Answer < ActiveRecord::Base
  attr_accessible :field_name, :field_index, :text

  belongs_to :solution

  def field_label
    Field.new(nil, field_name, field_index).label
  end

  def as_json(options={})
    super(options.merge(methods: :field_label))
  end
end
