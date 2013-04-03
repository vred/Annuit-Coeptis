class Comment < ActiveRecord::Base
  attr_accessible :comment, :comment_type, :location_id, :posted_at, :user_id
end
