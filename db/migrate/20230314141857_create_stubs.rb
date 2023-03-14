class CreateStubs < ActiveRecord::Migration[6.1]
  def change
    create_table :stubs do |t|
      t.references :user, null: false, foreign_key: true
      t.text :start_url, :limit => 2048
      t.string :end_url, unique: true
      t.integer :count, :null => false, :default => 0

      t.timestamps
    end
  end
end
