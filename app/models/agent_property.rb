class AgentProperty < ActiveRecord::Base
  belongs_to :agent
  belongs_to :property
  has_many :property_values

  attr_accessible :status, :update_count, :property
end
