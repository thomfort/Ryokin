class CreateAdvisors < ActiveRecord::Migration
  def change
    create_table :advisors do |t|
      t.integer :advisor_type_id
      t.integer :bank_id
      t.string :lastname
      t.string :firstname

      t.timestamps
    end
  end
end
