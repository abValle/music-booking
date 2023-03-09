class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :dispatch_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit::Authorization

  # Pundit: allow-list approach
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  def dispatch_user
    return unless current_user && request.get?

    if current_user.musician.blank? && current_user.company.blank?
      path = current_user.boolean_company? ? new_company_path : new_musician_path
    end

    redirect_to path unless path.nil? || path == request.path
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    user_keys = %i[boolean_company]
    devise_parameter_sanitizer.permit(:sign_up, keys: user_keys)

    # For additional in app/views/devise/registrations/edit.html.erb
    # devise_parameter_sanitizer.permit(:account_update, keys: user_keys)
  end
end
