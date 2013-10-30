class CreateAgentProperties < ActiveRecord::Migration
  def change
    create_table :agent_properties do |t|
      t.references :property
      t.references :agent
      t.string :status
      t.integer :update_count

      t.timestamps
    end
    add_index(:agent_properties, :property_id)
    add_index(:agent_properties, :agent_id)
  end
end
