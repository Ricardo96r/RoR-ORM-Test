require 'descriptive_statistics'
require 'memory_profiler'
require 'os'
require "faker"

class MetricsController < ApplicationController
  def index
    @os = OS.report
  end

  def tiempo_medio_de_respuesta
    resultMs = Array.new
    activateDB()
    100.times do |index|
      benchmark = Benchmark.measure {
        Student.find(index + 1)
      }
      result = benchmark.real * 1000
      resultMs.push(result.round(4))
    end

    @xresult = (resultMs.sum / resultMs.length).round(4)
    @mean = resultMs.mean.round(4)
    @standard_deviation = resultMs.standard_deviation.round(4)
    @error = error(resultMs)
    @time = resultMs
  end

  def rendimiento_medio
    result = Array.new

    count = 1
    100.times do |j|
      activateDB()
      now = Time.now
      i = 0
      while getMiliseconds(now) <= 1000  do
        i +=1
        Student.find(count)
        count += 1
      end
      result.push(i)

      p j
      p count
    end

    @xresult = ((result.sum / 1)/100).round(4)
    @mean = result.mean.round(4)
    @standard_deviation = result.standard_deviation.round(4)
    @error = error(result)
    result.each { |key, value| puts value }
    @result = result
    @request = result
  end

  def utilizacion_media_del_procesador
    resultOperationTime = Array.new
    resultProccesorTime = Array.new
    activateDB()
    100.times do |index|
      time = 0
      benchmark = Benchmark.measure {
        time += (Benchmark.measure {
          Lesson.find(index + 1)
        }).real
        time += (Benchmark.measure {
          Student.find(index + 1)
        }).real
        time += (Benchmark.measure {
          Teacher.find(index + 1)
        }).real
      }
      resultOperationTime.push((benchmark.real * 1000).round(4))
      resultProccesorTime.push((time * 1000).round(4))
    end

    xResult = 0
    100.times do |i|
      xResult  += (resultProccesorTime[i] / resultOperationTime[i])
    end
    @xResult = (xResult / 100).round(4)
    @msMean = resultOperationTime.mean.round(4)
    @msDesvest = resultOperationTime.standard_deviation.round(4)
    @msError = error(resultOperationTime)
    @ms2Mean = resultProccesorTime.mean.round(4)
    @ms2Desvest = resultProccesorTime.standard_deviation.round(4)
    @ms2Error = error(resultProccesorTime)
    @time = resultOperationTime
    @timeProccesor = resultProccesorTime
  end

  def capacidad_de_procesamiento_de_transacciones
    peticiones = Array.new
    observations = 100

    observations.times do |index|
      activateDB()
      now = Time.now
      i = 0
      while getMiliseconds(now) <= 1000  do
        i +=1
        ActiveRecord::Base.transaction do
          students = []
          20.times do |index|
            students.push({
                              name: Faker::Name.name,
                              lastname: Faker::Name.last_name,
                              birthday: Faker::Date.backward(),
                              address: Faker::Address.full_address
                          })
          end
          teacher = {
              name: Faker::Name.name,
              lastname: Faker::Name.last_name,
              birthday: Faker::Date.backward(),
              address: Faker::Address.full_address
          }
          lesson = {
              name: Faker::Educator.course_name,
          }
          students = Student.create(students)
          teacher = Teacher.create(teacher)
          lesson['teacher_id'] = teacher.id
          lesson = Lesson.create(lesson)
          lesson.students = students
        end
      end
      p index
      peticiones.push(i)
    end

    @xResult = peticiones.mean.round(4)
    @mean = peticiones.mean.round(4)
    @standard_deviation = peticiones.standard_deviation.round(4)
    @error = error(peticiones)
    @time = peticiones
  end

  def cantidad_media_de_memoria_utilizada
    result = Array.new

    100.times do |i|
      student = Student.find(i + 1)
      bytes = ActiveSupport::JSON.encode(student).size
      result.push(bytes)
    end

    @mean = result.mean.round(4)
    @standard_deviation = result.standard_deviation.round(4)
    @error = error(result)
    @memory = result
  end

  def error(values)
    result = 3*(values.standard_deviation/Math.sqrt(values.length));
    return result.round(4)
  end

  def activateDB()
    Student.find((10000))
  end

  def getMiliseconds(now)
    result = (Time.now - now) * 1000;
    return result.round(4)
  end
end
