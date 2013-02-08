class Stat < ActiveRecord::Base
  belongs_to :user
  attr_accessible :current, :max
  
  def calculate
     size = 0
     self.user.nodes.each do |n|
	size += n.size.to_i	
     end
     self.current = size
     self.save
  end
end
