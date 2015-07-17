module Admin
  class SessionsController < BaseController
    skip_before_action :authenticate_staff!

    def new
    end

    def create
      staff = Staff.find_by_name(params[:name])
      if staff && staff.authenticate(params[:password])
        session[:staff_id] = staff.id
        redirect_to admin_dashboard_path, notice: 'Logged in.'
      else
        flash.now.alert = 'Name or password is invalid.'
        render 'new'
      end
    end

    def destroy
      session[:staff_id] = nil
      redirect_to admin_login_path, notice: 'Logged out.'
    end
  end
end
