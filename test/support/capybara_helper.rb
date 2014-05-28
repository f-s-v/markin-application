module CapybaraHelper
  def sign_in(user)
    visit new_user_session_path
    if current_path == new_user_session_path
      fill_in 'user_email', with: users(user).email
      fill_in 'user_password', with: 'user123'
      find('input[name~=commit]').click
    end
  end
end