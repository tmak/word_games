require 'spec_helper'

describe MadLib do
  describe "#resolve" do
    it "yields each field" do
      mad_lib = FactoryGirl.build(:mad_lib, text: "{field} - That's a {field, ending in -ing} - {field}")

      expect {|probe| mad_lib.resolve(&probe) }.to yield_successive_args(Field.new(id: 0, type: "field", index: 1),
                                                                          Field.new(id: 1, type: "field", description: "ending in -ing", index: 1),
                                                                          Field.new(id: 2, type: "field", index: 2))
    end

    it "replaces the field placeholders with the yielded answers" do
      mad_lib = FactoryGirl.build(:mad_lib, text: "{field} - That's the {field, ending in -er} - {field}")
      answers = ["First field", "center", "End"]

      result = mad_lib.resolve do |field_name, field_index|
        answers.shift
      end

      expect(result).to eq("First field - That's the center - End")
    end
  end
end
