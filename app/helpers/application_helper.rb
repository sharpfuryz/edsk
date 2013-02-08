module ApplicationHelper
def ext_img(file)
	"mimetypes/file_extension_#{file}.png"
end

def format_size(size)
	isize = size.to_i
	if isize < 1024000
	# Lesser then Mb
		"#{isize.div(1000)} Kb"
	else
		"#{isize.div(1024000)} Mb"
	end
end

end
