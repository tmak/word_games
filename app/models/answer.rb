class Answer < ActiveRecord::Base
  attr_accessible :field_name, :field_index, :text

  belongs_to :solution
end
