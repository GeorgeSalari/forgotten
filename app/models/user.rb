class User < ApplicationRecord
  has_secure_password
  enum role: [:user, :forgotten, :journalist, :admin, :superadmin]
end
