class ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  class << self
    def policies
      @policies ||= Dir.chdir(Rails.root.join('app/policies')) do
        Dir['**/*_policy.rb'].collect do |file|
          file.chomp('.rb').camelize.constantize unless file == File.basename(__FILE__)
        end.compact
      end
    end

    def resource
      name.chomp('Policy')
    end

    def actions
      @actions ||= []
    end

    def permit(action_or_actions)
      acts = Array(action_or_actions).collect(&:to_s)
      acts.each do |act|
        define_method("#{act}?") { can? act }
      end
      actions.concat(acts)
    end
  end

  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def read?
    false
  end

  def index?
    read?
  end

  def show?
    read?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  private

  def can?(action)
    permission = {
      action: action,
      resource: record.is_a?(Class) ? record.name : record.class.name
    }
    user.permissions.exists?(permission)
  end
end
