module AuthorizationErrorsConcern
  extend ActiveSupport::Concern

  included do
    rescue_from CanCan::AccessDenied, with: :handle_access_denied
    rescue_from CanCan::AuthorizationNotPerformed, with: :handle_access_denied
  end

  def handle_access_denied(exception)
    report_error(exception)
    message = exception.message
    if exception.is_a?(CanCan::AuthorizationNotPerformed) and not Rails.env.development?
      message = I18n.t 'errors.unknown'
    end
    reset_response
    respond_to do |format|
      format.json { render json: {status: 'error', message: message}, status: 401 }
      format.html { redirect_to after_sign_in_path_for(current_user), alert: message }
    end
  end
end
