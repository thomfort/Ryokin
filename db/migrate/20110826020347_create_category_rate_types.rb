class CreateCategoryRateTypes < ActiveRecord::Migration
  def self.up
    create_table :categories_rate_types do |t|
      t.integer :category_id, :nil => false
      t.integer :rate_type_id, :nil => false
      t.timestamps
    end
  end

  def self.down
    drop_table :categories_rate_types
  end
end
