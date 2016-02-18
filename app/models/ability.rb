class Ability
  include CanCan::Ability

   def initialize(user)
        if user
            can [:index, :show], User
            can [:edit, :update, :destroy], User, :id => user.id
            can [:welcome, :index, :show], OpenJob
            can [:index, :show, :about, :new, :create, :update, :manage], Company
        else 
            can [:welcome, :index, :show], OpenJob
            can [:index, :show, :about], Company
            can [:index, :show, :new], User
        end
    end
end
