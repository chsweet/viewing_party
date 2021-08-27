class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def user_email
    User.find(self.user_id).email
  end
end
