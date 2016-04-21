class Food
  include Mongoid::Document
  include Mongoid::Timestamps

  field :food_id, type: String
  field :name, type: String

end
