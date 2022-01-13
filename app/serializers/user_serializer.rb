class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :name
   has_many :user_times
end
