class AgentPropertiesController < ApplicationController

  def show
    @values = PropertyValue.where(:agent_property_id => params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @values }
    end
  end

  def xml_errors
    @xml_with_errors = AgentProperty.where(:agent_id => nil)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @xml_with_errors }
    end
  end

end
