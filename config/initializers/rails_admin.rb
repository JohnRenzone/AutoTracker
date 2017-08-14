# RailsAdmin config file. Generated on October 19, 2013 23:33
# See github.com/sferik/rails_admin for more informations

if defined? RailsAdmin

  # Override RailsAdmin default application helpers.
  module ApplicationHelperOverrides
    def edit_user_Link &block
      return nil unless authorized?(:edit, _current_user.class, _current_user) && _current_user.respond_to?(:email)
      return nil unless abstract_model = RailsAdmin.config(_current_user.class).abstract_model
      return nil unless edit_action = RailsAdmin::Config::Actions.find(:edit, controller: controller, abstract_model: abstract_model, object: _current_user)
      content = if block_given?
                  yield
                else
                  _current_user.email
                end
      link_to content, url_for(action: edit_action.action_name, model_name: abstract_model.to_param, id: _current_user.id, controller: 'rails_admin/main')
    end
  end
  RailsAdmin::ApplicationHelper.send :include, ApplicationHelperOverrides


  RailsAdmin.config do |config|

    ################  Global configuration  ################

    ## == Devise ==
    config.authenticate_with do
      warden.authenticate! scope: :user
    end
    config.current_user_method(&:current_user)

    ## == Cancan ==
    config.authorize_with do
      redirect_to main_app.root_path unless warden.user.admin?
    end

    config.main_app_name = Proc.new { |controller| [I18n.t('brand.name'), I18n.t('admin.dashboard.name')] }

    config.included_models = ['User', 'Dealership']

    config.actions do
      dashboard # mandatory
      index # mandatory
      export do
        except ['User', 'Dealership']
      end

      bulk_delete do
        except ['User', 'Dealership']
      end
      show
      edit
      new do
        except ['User', 'Dealership']
      end

      delete do
        except ['User', 'Dealership']
      end
    end
  end
end
