class NodesController < ApplicationController
  before_filter :authenticate_user!
  
  # Drag and drop file upload
  # POST /nodes/dnd
  def dnd
	@node = current_user.nodes.new
	@node.ufile = params[:file]
	@node.save
	respond_to do |format|
	  format.html { render text: 'OK'}
	  format.json { render json: @node.to_json }
	end
  end

  # GET /nodes
  # GET /nodes.json
  def index
    @nodes = current_user.nodes.order('updated_at DESC')

    respond_to do |format|
      format.html { render layout: 'sidebar' }
      format.json { render json: @nodes }
    end
  end
  
  # Same as index, but for partial, sorting and other stuff
  # GET /nodes/table
  # TODO: GET /node/table.json
  def table
    @nodes = current_user.nodes.order('updated_at DESC')
    respond_to do |format|
      format.html { render partial: "table"}
      format.json { render json: @nodes }
    end
  end

  # POST /nodes/search
  # POST /nodes/search.json
  def search
    @nodes = current_user.nodes.sbt params[:query]

    respond_to do |format|
      format.html { render partial: "table" }
      format.json { render json: @nodes }
    end
  end

  # GET /nodes/1
  # GET /nodes/1.json
  def show
    @node = current_user.nodes.find(params[:id])
    begin
    send_file @node.ufile.path , :disposition => 'inline', :type => 'application/octet-stream'
    rescue ActionController::MissingFile
    	render text: "File lost"
    end
  end

  # GET /nodes/new
  # GET /nodes/new.json
  def new
    @node = Node.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @node }
    end
  end

  # GET /nodes/1/edit
  def edit
    @node = current_user.nodes.find(params[:id])
  end

  # POST /nodes
  # POST /nodes.json
  def create
    @node = Node.new(params[:node])
    # TODO: Check for duplicates
    # TODO: Forbid if stat limited
    @node.user_id = current_user.id
    respond_to do |format|
      if @node.save
        format.html { redirect_to nodes_path }
        format.json { render json: @node, status: :created, location: @node }
      else
        format.html { render action: "new" }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nodes/1
  # PUT /nodes/1.json
  def update
    @node = current_user.nodes.find(params[:id])
    respond_to do |format|
      if @node.update_attributes(params[:node])
        format.html { redirect_to nodes_path }
        format.json { respond_with_bip(@node) }
      else
        format.html { render action: "edit" }
        format.json { respond_with_bip(@node)}
      end
    end
  end

  # DELETE /nodes/1
  # DELETE /nodes/1.json
  def destroy
    @node = current_user.nodes.find(params[:id])
    Thread.new do
	@node.remove_ufile! # TODO: Obtain queue
    end
    @node.destroy

    respond_to do |format|
      format.html { redirect_to nodes_url }
      format.js { render text: "$('#node_#{@node.id}').remove();" }
      format.json { head :no_content }
    end
  end
end
