class ViewerController < ApplicationController
before_filter :authenticate_user!
  def image
    @node = current_user.nodes.find params[:id]
    send_file @node.ufile.path , :disposition => 'inline', :type => "image/#{@node.extension}"
  end
end
