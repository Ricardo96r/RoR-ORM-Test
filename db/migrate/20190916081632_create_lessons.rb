class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.string :name
      t.belongs_to :teacher
      t.timestamps
    end
    create_table :lessons_students, id: false do |t|
      t.belongs_to :student
      t.belongs_to :lesson
    end
  end
end