class Node < ActiveRecord::Base
  	belongs_to :user
	mount_uploader :ufile, UfileUploader
	attr_accessible :user_id, :mimetype, :extension, :size, :title, :ufile, :md5digest
	after_validation :set_attrs
	after_destroy :recalc
	
	def calculate_digest
	    self.md5digest = Digest::MD5.file(self.ufile.path)
	end
	
	def set_attrs
	   self.title = self.ufile.identifier
	   self.extension = self.ufile.file.extension
	   self.mimetype = self.ufile.file.content_type
	   self.size = self.ufile.size
	   # recalculate size
	   self.user.stat.calculate
	end
	def recalc
	   self.user.stat.calculate
	end
	
	def self.sbt(q)
		# TODO: Sanitize sql
		where("title like '%#{q}%'")
	end
end
