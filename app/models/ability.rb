class Ability
  include CanCan::Ability

   def initialize(user)
        if user
            can [:index, :show], User
            can [:edit, :update, :destroy], User, :id => user.id
            can [:welcome, :index, :show, :create, :new], OpenJob
            can [:index, :show, :about, :new, :create], Company

            can [:edit, :update, :administration], Company do |p|
                p.users.includes(user)
            end
        else 
            can [:welcome, :index, :show], OpenJob
            can [:index, :show, :about], Company
            can [:index, :show, :new, :create], User
        end
    end
end
