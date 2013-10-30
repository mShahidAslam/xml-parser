class AgentsController < ApplicationController

  def index
    @agents = Agent.all
  end

  # GET /agents/1
  # GET /agents/1.json
  def show
    @agent = Agent.find(params[:id])
    @agent_properties = @agent.agent_properties

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @agent }
    end
  end


end
