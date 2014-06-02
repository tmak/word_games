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
end
