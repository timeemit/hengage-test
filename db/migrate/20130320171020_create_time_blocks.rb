class CreateTimeBlocks < ActiveRecord::Migration
  def change
    create_table :time_blocks do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :user
      t.references :project

      t.timestamps
    end
    add_index :time_blocks, :user_id
    add_index :time_blocks, :project_id
  end
end
