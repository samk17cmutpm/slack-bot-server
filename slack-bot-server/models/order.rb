class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  field :menu_id, type: String
  field :food_name, type: String
  field :total, type: Integer, default: 1
  field :user_id, type: String

end
