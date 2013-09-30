class CreateReadings < ActiveRecord::Migration
  def up
    create_table :readings do |t|
      t.json :data
      t.datetime :read_time
      t.timestamps
    end
  end

  def down
    drop_table :readings
  end
end
