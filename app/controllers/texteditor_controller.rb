class TexteditorController < ApplicationController
  before_filter :authenticate_user!

  def create
    title = params[:title]
    filename = "#{Rails.root}/files/#{current_user.id}/#{title}.txt"
    #file = File.new(filename,"w")
    #  file.write("Stub")
    #file.close
    @node = current_user.nodes.create do |n|
	n.ufile = File.open(filename,"w")
    end
    # Call edit action
    redirect_to "/editor/#{@node.id}"
  end
  
  def edit
    @node = current_user.nodes.find params[:id]
    file = File.open(@node.ufile.path, "rb")
    @content = file.read
    @content = @content.force_encoding("UTF-8")
    file.close
  end

  def save
    @node = current_user.nodes.find params[:id]
    @content = params[:content].force_encoding("UTF-8")
    file = File.open(@node.ufile.path, "w")
    file.write(@content)
    file.close
    @node.update_attribute(:updated_at, Time.now)# For timestamps
    render template: "texteditor/edit"
  end
end
