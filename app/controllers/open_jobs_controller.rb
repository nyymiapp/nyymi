class OpenJobsController < ApplicationController
  load_and_authorize_resource
  before_action :set_open_job, only: [:show, :edit, :update, :destroy]

  # GET /open_jobs
  # GET /open_jobs.json
  def index
    @open_jobs = OpenJob.all
  end

  # GET /open_jobs/1
  # GET /open_jobs/1.json
  def show
    @application = Application.new
    @application.experiences.build
    if current_user
      @application.user = current_user
      @application.open_job = @open_job
    end
  end

  # GET /open_jobs/new

   def administration
    @open_job = OpenJob.find(params[:id])
    if not current_user or !@open_job.company.users.include? current_user
      raise CanCan::AccessDenied.new("You're not admin!", :administration, OpenJob)
    end

    if session[:show_abandoned] == nil or session[:show_abandoned] == "false"
      @applications = @open_job.applications.not_abandoned
    else 
      @applications = @open_job.applications
    end
  end

  def current_user_open_jobs
    if current_user
      render json: current_user.open_jobs
    end
  end

  def toggle_showing_abandoned
    if session[:show_abandoned] == nil || session[:show_abandoned] == "false"
      session[:show_abandoned] = "true"
    else 
      session[:show_abandoned] = "false"
    end
    redirect_to :back
  end

  # GET /open_jobs/1/edit
  def edit
  end

  # POST /open_jobs
  # POST /open_jobs.json
  def create
    @open_job = OpenJob.new(open_job_params)
    @open_job.companyname = @open_job.company.name
    if not current_user or not @open_job.company.users.includes(current_user)
      redirect_to :root, notice: "You must be admin of company to create new open job!"
    end
    if not @open_job.save
       redirect_to :back, notice: "Nimeä tai viimeistä hakupäivää ei asetettu tai se on menneisyydessä!"
       return
    end
    respond_to do |format|
      if @open_job.save
        format.html { redirect_to administration_company_path(@open_job.company), notice: 'Avoin työpaikka luotu. Saat sähköpostin kun siihen tulee hakemus.' }
        format.json { render :show, status: :created, location: @open_job }
      else
        format.html { render :new }
        format.json { render json: @open_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /open_jobs/1
  # PATCH/PUT /open_jobs/1.json
  def update
    respond_to do |format|
      if @open_job.update(open_job_params)
        format.html { redirect_to @open_job, notice: 'Open job was successfully updated.' }
        format.json { render :show, status: :ok, location: @open_job }
      else
        format.html { render :edit }
        format.json { render json: @open_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /open_jobs/1
  # DELETE /open_jobs/1.json
  def destroy
    @open_job.destroy
    respond_to do |format|
      format.html { redirect_to open_jobs_url, notice: 'Open job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_open_job
      @open_job = OpenJob.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def open_job_params
      params.require(:open_job).permit(:company_id, :name, :description, :expires)
    end
end
