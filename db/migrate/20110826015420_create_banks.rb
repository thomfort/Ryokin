class CreateBanks < ActiveRecord::Migration
  def self.up
    create_table :banks do |t|
      t.string :name
      t.string :abbr
      t.string :logo_url

      t.timestamps
    end
  end

  def self.down
    drop_table :banks
  end
end
