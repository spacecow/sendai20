class AddGeocodeToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
    add_column :users, :address, :string
    remove_column :users, :username
  end

  def self.down
    remove_column :users, :address
    remove_column :users, :longitude
    remove_column :users, :latitude
    add_column :users, :username, :string
  end
end
