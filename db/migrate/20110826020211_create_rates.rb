class CreateRates < ActiveRecord::Migration
  def self.up
    create_table :rates do |t|
      t.integer :bank_id
      t.integer :category_rate_type_id
      t.decimal :percent_rate

      t.timestamps
    end
  end

  def self.down
    drop_table :rates
  end
end
