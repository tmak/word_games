class Solution < ActiveRecord::Base
  belongs_to :mad_lib

  has_many :answers

  def fill_field(field, options)
    field = Field.from_label(field) if field.is_a?(String)
    text = options.fetch(:with)
    answers.create(field_name: field.name, field_index: field.index, text: text)
  end

  def resolve
    mad_lib.resolve do |field|
      answer = answers.where(field_name: field.name, field_index: field.index).first

      if answer
        answer.text
      else
        ""
      end
    end
  end

  alias_method :result, :resolve

  def as_json(options={})
    super(options.merge(include: { answers: { methods: :field_label }}, methods: :result))
  end
end
