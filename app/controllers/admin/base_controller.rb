class Admin::BaseController < AppController
  include Pundit

  layout 'admin'
  helper_method :current_staff

  before_action :authenticate_staff!

  rescue_from Pundit::NotAuthorizedError, with: :unauthorized

  private

  def current_staff
    @current_staff ||= Staff.find(session[:staff_id]) if session[:staff_id]
  end
  alias_method :pundit_user, :current_staff

  def authenticate_staff!
    redirect_to admin_login_path, alert: 'You need to login first.' if current_staff.nil?
  end

  def unauthorized
    redirect_to request.referrer || admin_dashboard_path, alert: 'You are not authorized to perform this action.'
  end
end
