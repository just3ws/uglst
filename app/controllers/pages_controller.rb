class PagesController < ApplicationController
  layout 'root', only: %i(root)

  def privacy
    @privacy = MultiJson.load(Net::HTTP.get(URI('http://www.iubenda.com/api/privacy-policy/137049/no-markup')))['content']
  end

  def root
    if current_user
      redirect_to user_groups_path, notice: 'Welcome back!'
    end

    @user_groups = UserGroup.unscoped.order('random()').limit(3)

    @form = HomepageRegistrationForm.new(user_group: UserGroup.new, user: User.new)
  end

  def awesome
    @form = HomepageRegistrationForm.new(params['homepage_registration_form'])

    @user = User.find_or_create_by(email: @form.email) do |model|
      model.password = @form.password
      model.password_confirmation = @form.password
    end

    sign_in(@user)

    geo = Geocoder.search(@form.address).first

    @user_group = current_user.user_groups_registered.build(
      address: geo.address,
      city: geo.city,
      country: geo.country,
      description: "#{@form.name} is a User-Group based in #{geo.address}.",
      homepage: @form.homepage,
      latitude: geo.latitude,
      longitude: geo.longitude,
      name: @form.name
    )

    # redirect_to :back, :flash => { :new_solution_errors => solution.errors }
    @user_group.save

    WelcomeEmailJob.perform_async(@user.id) if @user.valid? && @user.persisted?
  end
end
