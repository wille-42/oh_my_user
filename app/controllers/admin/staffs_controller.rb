module Admin
  class StaffsController < BaseController
    def index
      authorize Staff
      @staffs = policy_scope(Staff).includes(:roles)
    end

    def new
      @staff = Staff.new
      authorize @staff
    end

    def create
      @staff = Staff.new(staff_params)
      authorize @staff
      if @staff.save
        redirect_to admin_staffs_path, notice: 'Staff created.'
      else
        render 'new'
      end
    end

    def edit
      @staff = Staff.find(params[:id])
      authorize @staff
    end

    def update
      @staff = Staff.find(params[:id])
      authorize @staff
      if @staff.update(staff_params)
        redirect_to admin_staffs_path, notice: 'Staff updated.'
      else
        render 'edit'
      end
    end

    def destroy
      @staff = Staff.find(params[:id])
      authorize @staff
      @staff.destroy
      redirect_to admin_staffs_path
    end

    private

    def staff_params
      params.require(:staff).permit(:name, :password, :password_confirmation, role_ids: [])
    end
  end
end
