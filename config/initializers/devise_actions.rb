# Put this somewhere it will get auto-loaded, like config/initializers
module DeviseActions
  def self.add_actions
    ## Example of adding a before_action to all the Devise controller
    ## actions we care about.
    # [
    # Devise::SessionsController,
    # Devise::RegistrationsController,
    # Devise::PasswordsController
    # ].each do |controller|
    # controller.before_action :prepare_for_mobile
    # end

    ## Example of adding one selective before_action.
    #Devise::RegistrationsController.after_action :send_welcome_email, only: :create
  end

  add_actions
end
