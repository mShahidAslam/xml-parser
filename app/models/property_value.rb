class PropertyValue < ActiveRecord::Base
  belongs_to :agent_property, :foreign_key => 'agent_property_id'

  attr_accessible :value
end
