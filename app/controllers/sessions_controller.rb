class SessionsController < ApplicationController

  def new
    # renderöi kirjautumissivun
  end

   def create
      user = User.find_by username: params[:username]
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user_path(user), notice: "Tervetuloa takaisin!"
      else
        redirect_to :back, notice: "Käyttäjänimi ja/tai salasana väärin"
      end
    end

  def destroy
    # nollataan sessio
    session[:user_id] = nil
    # uudelleenohjataan sovellus pääsivulle
    redirect_to :root
  end
end