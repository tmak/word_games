class Field
  attr_reader :id
  attr :name, :index

  def self.from_label(label)
    match = label.match(/([\w,\- ]+) \((\d+)\):?/)

    new(nil, match[1], match[2])
  end

  def initialize(id, name, index)
    @id = id
    @name = name.downcase
    @index = index.to_i
  end

  def label
    "#{@name.capitalize} (#{@index})"
  end

  def ==(o)
    o.class == self.class && o.id == @id && o.name == @name && o.index == @index
  end

  alias_method :eql?, :==

  def as_json(options=nil)
    {
      id: id,
      name: name,
      index: index,
      label: label
    }
  end
end