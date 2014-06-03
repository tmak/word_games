class Field
  attr_reader :id
  attr_accessor :type, :description, :index

  def self.from_name(name, attrs={})
    type, description = name.split(',', 2)
    new(attrs.merge(type: type, description: description))
  end

  def self.from_label(label, attrs={})
    match = label.match(/([\w,\- ]+) \((\d+)\):?/)
    from_name(match[1], attrs.merge(index: match[2]))
  end

  def initialize(attrs)
    @id = attrs[:id]
    @type = attrs.fetch(:type).strip.downcase
    @description = (attrs[:description] || "").strip.downcase
    @index = attrs[:index].to_i if attrs[:index].present?
  end

  def name
    if description.blank?
      type
    else
      "#{type}, #{description}"
    end
  end

  def label
    "#{name.capitalize} (#{index})"
  end

  def ==(o)
    o.class == self.class && o.id == id && o.type == type && o.description == description && o.index == index
  end

  alias_method :eql?, :==

  def as_json(options=nil)
    {
      id: id,
      type: type,
      description: description,
      index: index,
      name: name,
      label: label
    }
  end
end