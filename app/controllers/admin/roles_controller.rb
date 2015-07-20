module Admin
  class RolesController < BaseController
    def index
      @roles = Role.all
    end

    def show
      @role = Role.find(params[:id])
    end

    def new
      @role = Role.new
    end

    def create
      @role = Role.new(role_params)
      if @role.save
        redirect_to [:admin, @role], notice: 'Role created.'
      else
        render 'new'
      end
    end

    def edit
      @role = Role.find(params[:id])
    end

    def update
      @role = Role.find(params[:id])
      if @role.update(role_params)
        redirect_to [:admin, @role], notice: 'Role updated.'
      else
        render 'edit'
      end
    end

    def destroy
      @role = Role.find(params[:id])
      @role.destroy
      redirect_to admin_roles_path
    end

    private

    def role_params
      role_params = params.require(:role).permit(:name, permissions: [])
      role_params[:permissions] = build_permissions(role_params[:permissions] || [])
      role_params
    end

    def build_permissions(permissions)
      parse_permissions(permissions).collect do |permission|
        if @role.nil?
          Permission.new(permission)
        else
          @role.permissions.find_or_initialize_by(permission)
        end
      end
    end

    def parse_permissions(permissions)
      permissions.collect do |permission|
        action, resource = permission.split('#', 2)
        { action: action, resource: resource }
      end
    end
  end
end
