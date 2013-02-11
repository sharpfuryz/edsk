module ApplicationHelper

def gen_show_link(ext,node_id)
# Uberbydlo code; TODO: Refactor this code; Important
    lnk = ""
    if can_text_edit?(ext)
	lnk = "/texteditor/edit?id=#{node_id}"
    end
    if can_view?(ext)
	lnk = "/viewer/image?id=#{node_id}"
    end
    if lnk == ""
	lnk = "/nodes/#{node_id}"
    end
    return lnk
end

def can_text_edit?(ext)
    ApplicationController::EXTENSIONS_TEXT.include? ext
end

def can_view?(ext)
    ApplicationController::EXTENSIONS_IMAGES.include? ext
end

def ext_asset(file)
    if asset_exist?(ext_img(file))
	ext_img(file)
    else
	ext_img("bin")
    end
end

def ext_img(file)
	"mimetypes/file_extension_#{file}.png"
end

def asset_exist?(asset)
    !Rails.application.assets.find_asset("#{asset}").nil?
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
