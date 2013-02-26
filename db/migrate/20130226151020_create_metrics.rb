class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      # Where did they come from?
      t.integer  :iteration_id, limit: 8, null: false
      t.integer  :project_id,   limit: 8, null: false
      t.date     :captured_on

      # Actual metrics
      t.integer :unstarted, default: 0
      t.integer :started,   default: 0
      t.integer :finished,  default: 0
      t.integer :delivered, default: 0
      t.integer :accepted,  default: 0
      t.integer :rejected,  default: 0

      t.timestamps
    end

    add_index :metrics, [:project_id, :iteration_id, :captured_on]
  end
end
