class ChangeReadingsJsonToHstore < ActiveRecord::Migration
  def up
    remove_column :readings, :data
    add_column :readings, :data, :hstore
  end

  def down
    remove_column :readings, :data
    add_column :readings, :data, :json
  end
end
