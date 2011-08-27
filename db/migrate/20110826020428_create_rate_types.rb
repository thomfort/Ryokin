class CreateRateTypes < ActiveRecord::Migration
  def self.up
    create_table :rate_types do |t|
      t.string :name
      t.integer :nb_month

      t.timestamps
    end
  end

  def self.down
    drop_table :rate_types
  end
end
