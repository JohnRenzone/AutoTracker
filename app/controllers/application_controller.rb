class ApplicationController < ActionController::Base
  include UtilHelper

  if ENV['BASIC_AUTH']
    user, pass = ENV['BASIC_AUTH'].split(':')
    http_basic_authenticate_with name: user, password: pass
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Devise, require authenticate by default
  before_filter :authenticate_user!, :build_breadcrumbs
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # CanCan, check authorization unless authorizing with devise
  check_authorization unless: :skip_check_authorization?

  # Special handling for ajax requests.
  # Must appear before other rescue_from statements.
  rescue_from Exception, with: :handle_uncaught_exception

  include CommonHelper
  include ErrorReportingConcern
  include AuthorizationErrorsConcern

  def redirect_to(options = {}, response_status = {})
    Rails.logger.info("----> Redirected by #{caller(1).first rescue "unknown"}")
    super(options, response_status)
  end

  private
  def build_breadcrumbs
    if user_signed_in?
      add_breadcrumb "Home", :root_path, class: 'btn btn-default'

      case controller_name
        when 'dealerships'
          add_breadcrumb "Manage Dealerships", :dealerships_url, class: 'btn btn-default'
          case action_name
            when 'index'
              add_breadcrumb 'List', '#'
            when 'new', 'create'
              add_breadcrumb 'New', '#'
            when 'edit', 'update'
              add_breadcrumb 'Edit', '#'
            else
              add_breadcrumb action_name.humanize, '#'
          end
        when 'users'
          add_breadcrumb "Users", :users_url, class: 'btn btn-default'

          case action_name
            when 'dealers'
              add_breadcrumb "Manage Dealers", '#', class: 'btn btn-default disabled'
            when 'service_advisors'
              add_breadcrumb "Manage Service Advisors", '#', class: 'btn btn-default disabled'
            when 'technicians'
              add_breadcrumb "Manage Technicians", '#', class: 'btn btn-default disabled'
            when 'new_technician', 'create_technician'
              add_breadcrumb "Add #{t('users.roles.technician')}", '#', class: 'btn btn-default disabled'
            when 'index'
              add_breadcrumb 'List', '#'
            when 'new', 'create'
              add_breadcrumb 'New', '#'
            when 'edit', 'update'
              add_breadcrumb 'Edit', '#'
            else
              add_breadcrumb action_name.humanize, '#'
          end
        when 'vehicle_report_cards'
          case action_name
            when 'index'
              add_breadcrumb 'Reports', '#', class: 'btn btn-default disabled'
            when 'show'
              add_breadcrumb 'Reports', :vehicle_report_cards_path, class: 'btn btn-default'
              add_breadcrumb 'Show'
            when 'new', 'create'
              add_breadcrumb 'Reports', :vehicle_report_cards_path, class: 'btn btn-default'
              add_breadcrumb 'New'
            when 'edit', 'update'
              add_breadcrumb 'Reports', :vehicle_report_cards_path, class: 'btn btn-default'
              add_breadcrumb "Edit", '#', class: 'btn btn-default disabled'
          end
        when 'invitations'
          case action_name
            when 'new', 'create'
              title = "Invite #{current_user.invitable_roles.map(&:titleize).join(' / ')}"
              add_breadcrumb title, '#', class: 'btn btn-default disabled'
          end

        when 'registrations'
          case action_name
            when 'edit'
              add_breadcrumb I18n.t('account.edit.link'), '#', class: 'btn btn-default disabled'
          end
      end
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:invite) do |u|
      u.permit(:email, :role, :dealership_id)
    end
  end

  def skip_check_authorization?
    devise_controller? || is_a?(RailsAdmin::ApplicationController)
  end

  # Reset response so redirect or render can be called again.
  # This is an undocumented hack but it works.
  def reset_response
    self.instance_variable_set(:@_response_body, nil)
  end

  # Respond to uncaught exceptions with friendly error message during ajax requets
  def handle_uncaught_exception(exception)
    if request.format == :js
      Rails.logger.error exception.backtrace if Rails.env.development? or Rails.env.test?

      report_error(exception)
      flash.now[:error] = Rails.env.development? ? exception.message : I18n.t('errors.unknown')
      render 'layouts/uncaught_error.js'
    else
      raise
    end
  end

end
