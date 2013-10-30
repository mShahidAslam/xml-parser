class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :agent_unique_id
      t.string :name

      t.timestamps
    end

  end
end
