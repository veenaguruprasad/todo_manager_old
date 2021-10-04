class User < ActiveRecord::Base
  def to_displayable_string
    "#{id}. #{name} #{email}"
  end

  def self.to_displayable_list
    all.map { |user| user.to_displayable_string }
  end
end
