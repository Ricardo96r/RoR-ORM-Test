require 'test_helper'

class MetricsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get metrics_index_url
    assert_response :success
  end

  test "should get tiempo_de_respuesta" do
    get metrics_tiempo_de_respuesta_url
    assert_response :success
  end

  test "should get utilizacion_de_cache" do
    get metrics_utilizacion_de_cache_url
    assert_response :success
  end

  test "should get capacidad" do
    get metrics_capacidad_url
    assert_response :success
  end

  test "should get rendimiento" do
    get metrics_rendimiento_url
    assert_response :success
  end

  test "should get utilizacion_de_memoria" do
    get metrics_utilizacion_de_memoria_url
    assert_response :success
  end

  test "should get velocidad_bajo_estres" do
    get metrics_velocidad_bajo_estres_url
    assert_response :success
  end

end
