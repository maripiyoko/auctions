class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_raven_context

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end

  def set_raven_context
    if user_signed_in?
      Raven.user_context(id: current_user.id, type: current_user.class.name)
    end
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
