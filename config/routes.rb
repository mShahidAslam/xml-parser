XmlTest::Application.routes.draw do

  resources :agents
  match 'agent_property/:id/property' => 'agent_properties#show', :as => :property
  match 'xml_with_error' => 'agent_properties#xml_errors', :as => :xml_with_errors
  root :to => 'agents#index'
end
