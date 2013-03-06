class CreateIterations < ActiveRecord::Migration
  def change
    create_table :iterations do |t|
      t.integer :burndown_id

      t.integer  :pivotal_iteration_id

      t.datetime :starts_at
      t.datetime :finished_at

      t.timestamps
    end

    add_index :iterations, :burndown_id
    add_index :iterations, [:burndown_id, :pivotal_iteration_id]
  end
end
