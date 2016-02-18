class Ability
  include CanCan::Ability

   def initialize(user)
        if user
            can [:index, :show], User
            can [:edit, :update, :destroy, :my_companies], User, :id => user.id
            can [:welcome, :index, :show, :create, :new, :administration], OpenJob
            can [:index, :show, :about, :new, :create], Company
            can [:new, :create], Application

            can [:edit, :update, :administration, :destroy], Company do |p|
                p.users.includes(user)
            end

            can [:edit, :update, :administration, :destroy], OpenJob do |p|
                p.company.users.includes(user)
            end

            can [:show, :destroy], Application do |p|
                p.open_job.company.users.includes(user)
            end
        else 
            can [:welcome, :index, :show], OpenJob
            can [:index, :show, :about], Company
            can [:index, :show, :new, :create], User
        end
    end
end
