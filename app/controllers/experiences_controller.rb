class ExperiencesController < ApplicationController
  before_action :set_experience, only: [:show, :edit, :update, :destroy]

  # GET /experiences/1
  # GET /experiences/1.json
  def show
    
  end


  # POST /experiences
  # POST /experiences.json
  def create
    @experience = Experience.new(experience_params)
    puts "Application.count ExperiencesControllerissa: " + Application.count.to_s 
    @experience.application = Application.find(session[:current_application_id])
    @experience.save

    respond_to do |format|
      if @experience.save
        format.html { redirect_to @experience  }
        format.json { render :json => '#{@experience.id}' }
      else
        format.html { render :new }
        format.json { render json: @experience.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experience
      @experience = Experience.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def experience_params
      params.require(:experience).permit(:application_id, :place, :description, :start, :end, :strictplace)
    end
end
