class Lesson < ApplicationRecord
  has_one :teacher
  has_and_belongs_to_many :students
end
