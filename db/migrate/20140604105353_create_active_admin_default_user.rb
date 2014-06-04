class CreateActiveAdminDefaultUser < ActiveRecord::Migration

  def migrate(direction)
    super
    # Create a default user
    User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if direction == :up
  end

end
