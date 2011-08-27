class CreateCategoryRateTypes < ActiveRecord::Migration
  def self.up
    create_table :category_rate_types do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :category_rate_types
  end
end
