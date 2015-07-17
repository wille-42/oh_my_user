class Admin::BaseController < AppController
  layout 'admin'
  helper_method :current_staff

  before_action :authenticate_staff!

  def current_staff
    @current_staff ||= Staff.find(session[:staff_id]) if session[:staff_id]
  end

  def authenticate_staff!
    redirect_to admin_login_path, alert: 'You need to login first.' if current_staff.nil?
  end
end
