require 'libxml'

class Watcher
  include LibXML

  def self.watch

    callback = Proc.new do |modified, new_files, removed|

      # read the DTD file
      dtd = XML::Dtd.new(File.read(File.join(Rails.root, 'public', 'propertyList.dtd')))
      new_files.each do |new|

        # read the XML file so that it can be validated against DTD
        to_be_validated = XML::Document.file(new)

        begin
          to_be_validated.validate(dtd) # validate the recevied XML file against the DTD
          doc = Nokogiri::XML(File.open(new))
          # extract property values from the XML
          data = {}
          agent_id = doc.xpath('//agentID').text unless doc.css('//agentID').empty?
          agent_name = doc.xpath('//listingAgent//name').text unless doc.css('//listingAgent//name').empty?

          data['xml'] = doc.to_s
          data['property_type'] = 'Residence'
          data['Address'] = doc.xpath('//address').text unless doc.css('//address').empty?
          data['price'] = doc.xpath('//rent').text unless doc.css('//rent').empty?
          data['number_of_bedrooms'] = doc.xpath('//features//bedrooms').text unless doc.css('//features//bedrooms').empty?
          data['headline'] = doc.xpath('//headline').text unless doc.css('//headline').empty?
          data['description'] = doc.xpath('//description').text unless doc.css('//description').empty?

          agent = Agent.find_by_agent_unique_id_and_name(agent_id, agent_name)
          properties = Property.all

          # create a agent record if such agent does not exist already
          agent = create_agent(agent_id, agent_name, properties) if agent.nil?

          properties.map(&:name).each do |n|
            create_property_value(agent, n, data[n], properties)
          end
          agent.save!
        rescue => err
          xml_property = AgentProperty.new(:property => Property.where(:name => 'xml').first, :status => err.message)
          xml_property.property_values.new(:value => to_be_validated.to_s)
          xml_property.save!
        ensure
          File.delete(new) rescue nil
        end
      end
    end

    # start listening to pickup folder where agents will be placing there XML files.
    listener = Listen.to('pickup/', &callback)
    listener.start
    sleep
  end

  # create property agent
  def self.create_agent(agent_id, agent_name, properties)
    agent = Agent.new(:agent_unique_id => agent_id, :name => agent_name)
    agent.agent_properties.new(:update_count => 0, :status => 'valid',
                               :property => properties.select{|p| p.name == 'xml'}.first)
    %w{Address price number_of_bedrooms headline description property_type}.each do |property|
      agent.agent_properties.new(:update_count => 0, :status => 'present',
                                 :property => properties.select{|p| p.name == property}.first)
    end
    agent.save!
    agent
  end

  # save property variables
  def self.create_property_value(agent, attribute_type, xml_attr_value, properties)
    agent_prop = agent.agent_properties.where(:property_id => properties.select{ |p| p.name == attribute_type}.first.id).first
    if !xml_attr_value.nil? && !agent_prop.nil?
      agent_prop.property_values.new(:value => xml_attr_value)
      agent_prop.update_count += 1
      agent_prop.save!
    else
      agent_prop.assign_attributes(:status => 'deleted').save!
    end
  end

end