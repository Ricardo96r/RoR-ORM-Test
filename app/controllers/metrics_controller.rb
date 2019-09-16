require 'descriptive_statistics'
require 'memory_profiler'

class MetricsController < ApplicationController
  def index
  end

  def tiempo_de_respuesta
    resultMs = Array.new
    activateDB()
    100.times do |index|
      benchmark = Benchmark.measure {
        Student.find(index + 1)
      }
      result = benchmark.real * 1000
      resultMs.push(result.round(4))
    end

    @xresult = (resultMs.sum / 100).round(4)
    @mean = resultMs.mean.round(4)
    @standard_deviation = resultMs.standard_deviation.round(4)
    @error = error(resultMs)
    @time = resultMs
  end

  def rendimiento
    result = Array.new

    100.times do |j|
      activateDB()
      now = Time.now
      i = 0
      while getMiliseconds(now) <= 100  do
        i +=1
        Student.find(i + (j * 100))
      end
      result.push(i)
    end

    @xresult = ((result.sum / 0.100)/100).round(4)
    @mean = result.mean.round(4)
    @standard_deviation = result.standard_deviation.round(4)
    @error = error(result)
    result.each { |key, value| puts value }
    @result = result
    @request = result
  end

  def utilizacion_de_cache
    resultMs = Array.new
    100.times do
      benchmark = Benchmark.measure {
        Student.find(1)
      }
      resultMs.push((benchmark.real * 1000).round(4))
    end



    @msMean = resultMs.mean.round(4)
    @msDesvest = resultMs.standard_deviation.round(4)
    @msError = error(resultMs)
    @time = resultMs
  end

  def capacidad
    resultMs = Array.new
    1000.times do |index|
      benchmark = Benchmark.measure {
        Student.find(index + 1)
      }
      resultMs.push((benchmark.real * 1000).round(4))
    end

    @mean = resultMs.mean.round(4)
    @standard_deviation = resultMs.standard_deviation.round(4)
    @error = error(resultMs)
    @time = resultMs
  end

  def utilizacion_de_memoria
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

  def velocidad_bajo_estres
    resultMs = Array.new
    100.times do |index|
      benchmark = Benchmark.measure {
        100.times do |j|
          Student.find((j + 1) + (index * 100))
        end
      }
      resultMs.push((benchmark.real * 10).round(4))
    end

    @mean = resultMs.mean.round(4)
    @standard_deviation = resultMs.standard_deviation.round(4)
    @error = error(resultMs)
    @time = resultMs
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
