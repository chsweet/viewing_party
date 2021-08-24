class Follow < ApplicationRecord
  belongs_to :hosts, class_name: 'User'
  belongs_to :followeds, class_name: 'User'
end
