class Agent < ActiveRecord::Base
  has_many :agent_properties
  has_many :properties, :through => :agent_properties

end
