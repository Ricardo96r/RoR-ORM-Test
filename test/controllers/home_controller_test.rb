require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get Acerca" do
    get home_Acerca_url
    assert_response :success
  end

  test "should get Contacto" do
    get home_Contacto_url
    assert_response :success
  end

end
