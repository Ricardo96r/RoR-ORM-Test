class CreateTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :lastname
      t.string :birthday
      t.string :address

      t.timestamps
    end
  end
end
