class Field
  attr :name, :index

  def self.from_label(label)
    match = label.match(/([\w,\- ]+) \((\d+)\):?/)

    new(match[1].downcase, match[2].to_i)
  end

  def initialize(name, index)
    @name = name
    @index = index
  end
end