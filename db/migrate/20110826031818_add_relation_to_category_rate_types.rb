class AddRelationToCategoryRateTypes < ActiveRecord::Migration
  def self.up
    add_column :Category_Rate_Types, :category_id, :integer
    add_column :Category_Rate_Types, :rate_type_id, :integer
  end

  def self.down
    remove_column :Category_Rate_Types, :category_id
    remove_column :Category_Rate_Types, :rate_type_id
  end
end
