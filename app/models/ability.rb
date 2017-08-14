# CanCan Abilities
#
# See the wiki for details:
# https://github.com/ryanb/cancan/wiki/Defining-Abilities

class Ability
  include CanCan::Ability

  def initialize(user = User.new)
    alias_action :create, :read, :update, :destroy, to: :crud

    can :manage, Authentication, user_id: user.id
    can :manage, Inventory

    if user.admin?
      can :manage, Dealership
      can :crud, User
      can :read, VehicleReportCard
      can :edit, VehicleReportCard

    elsif user.dealer?
      can :crud, User, dealership_id: user.dealership_id
      can :login_as, User
      can :login, User, :role => ['service_advisor', 'technician'], dealership_id: user.dealership_id
      can :read, VehicleReportCard, :id => VehicleReportCard.joins(:user).where(users: { dealership_id: user.dealership_id})
      can :edit, VehicleReportCard, :id => VehicleReportCard.joins(:user).where(users: { dealership_id: user.dealership_id}).map(&:id)

    elsif user.service_advisor?
      can :read, VehicleReportCard, service_advisor_id: user.id
      can :edit, VehicleReportCard, service_advisor_id: user.id
      can :update, VehicleReportCard, service_advisor_id: user.id
      can :send_pdf, VehicleReportCard, service_advisor_id: user.id
      can :email_pdf, VehicleReportCard, service_advisor_id: user.id

    elsif user.technician?
      can :index, VehicleReportCard, :id => VehicleReportCard.where(user_id: user).map(&:id)
      can :show, VehicleReportCard, :id => VehicleReportCard.where(user_id: user).map(&:id)
      can :create, VehicleReportCard
      can :edit, VehicleReportCard, :id => VehicleReportCard.where(user_id: user).map(&:id)
      can :update, VehicleReportCard, :id => VehicleReportCard.to_be_reviewed.where(user_id: user).map(&:id)
      can :destroy, VehicleReportCard, :id => VehicleReportCard.to_be_reviewed.where(user_id: user).map(&:id)
    end
  end
end
