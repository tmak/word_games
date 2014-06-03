require 'spec_helper'

describe Field do
  describe "#from_label" do
    it "lowercases the name" do
      field = Field.from_label("Field, ending in -ing (1)")

      expect(field.name).to eq("field, ending in -ing")
    end

    it "converts the index to integer" do
      field = Field.from_label("Field, ending in -ing (2)")

      expect(field.index).to eq(2)
    end

    it "ignores a colon at the end of a label" do
      field = Field.from_label("Field, ending in -ing (1):")

      expect(field.name).to eq("field, ending in -ing")
      expect(field.index).to eq(1)
    end
  end

  it "generates a capitalized label with index at the end" do
    field = Field.new(type: "field", index: 3)

    expect(field.label).to eq("Field (3)")
  end

  it "has a JSON represenation" do
    expect(Field.new(id: 1, type: "field", description: "ending in -er", index: 3).as_json).to eq({
      id: 1,
      type: "field",
      description: "ending in -er",
      index: 3,
      name: "field, ending in -er",
      label: "Field, ending in -er (3)"
    })
  end
end
