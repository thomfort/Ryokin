class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.integer :advisor_id
      t.string :title
      t.text :tip

      t.timestamps
    end
  end
end
