class CreateResets < ActiveRecord::Migration
  def self.up
    create_table :resets do |t|
      t.string :code
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :resets
  end
end
