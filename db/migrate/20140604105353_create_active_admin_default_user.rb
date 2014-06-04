class CreateActiveAdminDefaultUser < ActiveRecord::Migration

  def migrate(direction)
    super
    # Create a default user
    User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', name: 'Example Admin') if direction == :up
  end

end
