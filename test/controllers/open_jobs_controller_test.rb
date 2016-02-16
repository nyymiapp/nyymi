require 'test_helper'

class OpenJobsControllerTest < ActionController::TestCase
  setup do
    @open_job = open_jobs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:open_jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create open_job" do
    assert_difference('OpenJob.count') do
      post :create, open_job: { company_id: @open_job.company_id, description: @open_job.description, expires: @open_job.expires, name: @open_job.name }
    end

    assert_redirected_to open_job_path(assigns(:open_job))
  end

  test "should show open_job" do
    get :show, id: @open_job
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @open_job
    assert_response :success
  end

  test "should update open_job" do
    patch :update, id: @open_job, open_job: { company_id: @open_job.company_id, description: @open_job.description, expires: @open_job.expires, name: @open_job.name }
    assert_redirected_to open_job_path(assigns(:open_job))
  end

  test "should destroy open_job" do
    assert_difference('OpenJob.count', -1) do
      delete :destroy, id: @open_job
    end

    assert_redirected_to open_jobs_path
  end
end
