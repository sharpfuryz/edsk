class TexteditorController < ApplicationController
  before_filter :authenticate_user!
  
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
