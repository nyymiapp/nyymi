require 'mail'
require 'rubygems'
require 'json'

class ApplicationsController < ApplicationController
  load_and_authorize_resource
  before_action :set_application, only: [:show, :edit, :update, :destroy]

  # GET /applications/1
  # GET /applications/1.json
  def show
  end

  # POST /applications
  # POST /applications.json
  def create
    @application = Application.new(params[:application])

    @application.user_id = current_user.id
    @application.open_job = OpenJob.find(params[:open_job_id])
    @application.freetext = params[:freetext]
    @application.abandoned = false

    if params[:experiences] != nil and params[:experiences] != ""
      hashi = JSON.parse(params[:experiences].to_json)
      hashi.each do |key, value|
        @experience = Experience.new(value)
        @experience.application = @application
        @experience.save
      end
    end

    @application.save

    send_email_for_admins(@application)

    @application.open_job.applications << @application
    @application.open_job.save!

    respond_to do |format|
      if @application.save
        format.html { redirect_to :back, notice: 'Application was successfully created.' }
        format.json { render :text => "/open_jobs"  }
      else
        format.html { render :new }
        format.json { render :text => "/open_jobs" }
      end
    end
  end

   def toggle_abandoned
    application = Application.find(params[:id])
    if application.abandoned == nil || application.abandoned == false
      application.abandoned = true
    else 
      application.abandoned = false
    end
    application.save!
    new_status = application.abandoned ? "hylätty" : "ei-hylätty"

    redirect_to :back, notice:"Hakemuksen status: #{new_status}"
  end

  def send_email_for_admins(application)
    application.open_job.company.users.each do |u|
      begin
        NotificationMailer.email("nyymi@nyymiapp.com", u.email, "Yrityksesi on saanut uuden hakemuksen.", "Uusi hakemus Nyymissä").deliver_now
      rescue => ex
        puts ex.message
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_params
      params.require(:application).permit(:open_job_id, :user_id, :freetext, :abandoned, experiences: Experience.attribute_names.collect { |att| att.to_sym })
    end
end
