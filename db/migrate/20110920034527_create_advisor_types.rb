class CreateAdvisorTypes < ActiveRecord::Migration
  def change
    create_table :advisor_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
