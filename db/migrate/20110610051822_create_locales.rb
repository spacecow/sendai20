class CreateLocales < ActiveRecord::Migration
  def self.up
    create_table :locales do |t|
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :locales
  end
end
