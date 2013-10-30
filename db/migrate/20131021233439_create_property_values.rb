class CreatePropertyValues < ActiveRecord::Migration
  def change
    create_table :property_values do |t|
      t.references :agent_property
      t.text :value

      t.timestamps
    end
    add_index(:property_values, :agent_property_id)
  end
end
