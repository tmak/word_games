class MadLib < ActiveRecord::Base
  FIELD_REGEX = /\{([\w,\- ]+)\}/

  attr_accessible :text

  has_many :solutions

  def has_field?(label)
    parse

    field = Field.from_label(label)
    @field_counts.has_key?(field.name) && @field_counts[field.name] >= field.index
  end

  def resolve
    parse

    field_placeholders_left = @field_placeholders.dup
    current_field_counts = @field_counts.dup

    @text_parts.map do |text_part|
      text = text_part

      unless field_placeholders_left.empty?
        field_name = field_placeholders_left.shift
        current_field_counts[field_name] -= 1
        field_index = @field_counts[field_name] - current_field_counts[field_name]
        text += yield(field_name, field_index).to_s
      end

      text
    end.join("")
  end

  private

  def parse
    return if @parsed

    @text_parts = []
    @field_placeholders = []

    text.split(/(\{[\w,\- ]+\})/).each do |item|
      if item.start_with?("{") && item.end_with?("}")
        @field_placeholders << item[1..-2]
      else
        @text_parts << item
      end
    end

    @field_counts = @field_placeholders.each_with_object(Hash.new(0)) {|field_name, field_counts| field_counts[field_name] += 1 }
    @parsed = true
  end
end
