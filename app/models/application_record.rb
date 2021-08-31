class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def user_email
    User.find(user_id).email
  end
end
