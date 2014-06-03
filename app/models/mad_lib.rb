class MadLib < ActiveRecord::Base
  FIELD_REGEX = /\{([\w,\- ]+)\}/

  attr_accessible :text

  has_many :solutions

  validates :text, presence: true

  def has_field?(label)
    parse

    field = Field.from_label(label)
    @field_counts.has_key?(field.name) && @field_counts[field.name] >= field.index
  end

  def fields
    parse

    @fields
  end

  def find_field(id)
    fields[id]
  end

  def resolve
    parse

    fields_left = @fields.dup

    @text_parts.map do |text_part|
      text = text_part

      unless fields_left.empty?
        field = fields_left.shift
        text += yield(field).to_s
      end

      text
    end.join("")
  end

  def as_json(options={})
    super(options.merge(methods: :fields))
  end

  private

  def parse
    return if @parsed

    @text_parts = []
    @fields = []
    @field_counts = {}
    field_index = 0

    text.split(/(\{[\w,\- ]+\})/).each do |item|
      if item.start_with?("{") && item.end_with?("}")
        field_index += 1
        field_name = item[1..-2]
        @field_counts[field_name] = 0 unless @field_counts.has_key?(field_name)
        @field_counts[field_name] += 1
        @fields << Field.new(@fields.length, field_name, @field_counts[field_name])
      else
        @text_parts << item
      end
    end

    @parsed = true
  end
end
