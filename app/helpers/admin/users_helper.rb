module Admin::UsersHelper
 def users_path(arg)
 	admin_users_path(arg)
 end
 def user_path(arg,arg2)
 	admin_user_path(arg,arg2)
 end
end
