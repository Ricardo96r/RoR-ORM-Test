class Teacher < ApplicationRecord
  has_many :teachers, through: :lessons
end