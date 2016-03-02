class Ability
  include CanCan::Ability

   def initialize(user)
        if user
            can [:show], User
            can [:edit, :update, :destroy, :my_companies, :messages], User, :id => user.id

            can [:welcome, :index, :show, :create, :new, :administration], OpenJob
            can [:index, :show, :about, :new, :create, :add_admin], Company
            can [:new, :create], Application

            can [:edit, :update, :administration, :destroy], Company do |p|
                p.users.include? user
            end

            can [:edit, :update, :administration, :destroy, :current_user_open_jobs, :toggle_showing_abandoned], OpenJob do |p|
                #p.company.users.include? user
                user.open_jobs.include? p
            end
            can [:show, :destroy, :toggle_abandoned], Application do |p|
                p.open_job.company.users.include? user
            end
            can [:show, :destroy, :edit], Conversation do |p|
                p.user == user or p.company.users.include? user 
            end
            can [:show, :destroy, :edit, :create, :new], Message 
        else 
            can [:welcome, :index, :show], OpenJob
            can [:index, :show, :about], Company
            can [:show, :new, :create], User
        end
    end
end
