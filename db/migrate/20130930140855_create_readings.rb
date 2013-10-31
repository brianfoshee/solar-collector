class CreateReadings < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :readings, id: :uuid do |t|
      t.json :data
      t.datetime :read_time
      t.timestamps
    end
  end
end
