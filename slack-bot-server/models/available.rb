class Available
  include Mongoid::Document
  include Mongoid::Timestamps

  field :team_id, type: String
  field :available, type: Boolean, default: true
  field :user_id, type: String
  field :menu_id, type: String 
end
