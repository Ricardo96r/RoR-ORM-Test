require 'descriptive_statistics'
require 'memory_profiler'

class MetricsController < ApplicationController
  def index
  end

  def tiempo_de_respuesta
    resultMs = Array.new
    100.times do |index|
      benchmark = Benchmark.measure {
        Student.find(index + 1)
      }
      resultMs.push(benchmark.real * 1000)
    end

    @mean = resultMs.mean
    @standard_deviation = resultMs.standard_deviation
    @error = error(resultMs)
    @time = resultMs
  end

  def rendimiento
    result = Array.new

    100.times do |j|
      now = Time.now
      i = 0
      while getMiliseconds(now) <= 100  do
        i +=1
        Student.find(i + (j * 100))
      end
      result.push(i)
    end

    @mean = result.mean
    @standard_deviation = result.standard_deviation
    @error = error(result)
    @request = result
  end

  def utilizacion_de_cache
    resultMs = Array.new
    100.times do
      benchmark = Benchmark.measure {
        Student.find(1)
      }
      resultMs.push(benchmark.real * 1000)
    end

    @msMean = resultMs.mean
    @msDesvest = resultMs.standard_deviation
    @msError = error(resultMs)
    @time = resultMs
  end

  def capacidad
    resultMs = Array.new
    1000.times do |index|
      benchmark = Benchmark.measure {
        Student.find(index + 1)
      }
      resultMs.push(benchmark.real * 1000)
    end

    @mean = resultMs.mean
    @standard_deviation = resultMs.standard_deviation
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

    @mean = result.mean
    @standard_deviation = result.standard_deviation
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
      resultMs.push(benchmark.real * 1000)
    end

    @mean = resultMs.mean
    @standard_deviation = resultMs.standard_deviation
    @error = error(resultMs)
    @time = resultMs
  end

  def error(values)
    return 3*(values.standard_deviation/Math.sqrt(values.length));
  end

  def getMiliseconds(now)
    return (Time.now - now) * 1000;
  end
end
