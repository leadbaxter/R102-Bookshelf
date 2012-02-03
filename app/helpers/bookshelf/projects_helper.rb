module Bookshelf
  module ProjectsHelper
    def destroy_user_session_path
      main_app.destroy_user_session_path
    end
    def edit_user_registration_path
      main_app.edit_user_registration_path
    end
  end
end
