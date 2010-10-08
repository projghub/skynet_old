require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  test "should get by_campaigns" do
    get :by_campaigns
    assert_response :success
  end

  test "should get by_ad_groups" do
    get :by_ad_groups
    assert_response :success
  end

  test "should get by_ads" do
    get :by_ads
    assert_response :success
  end

  test "should get by_publishers" do
    get :by_publishers
    assert_response :success
  end

  test "should get by_templates" do
    get :by_templates
    assert_response :success
  end

  test "should get by_template_types" do
    get :by_template_types
    assert_response :success
  end

end
