class ArtworksController < ApplicationController
  before_action :set_artwork, only: [:show, :edit, :update, :destroy]
  before_action :set_style, only: [:create]
  skip_before_action :verify_authenticity_token, :if => Proc.new{|c| c.request.format=='application/json'}
  before_action :api_auth, :if => Proc.new{|c| c.request.format=='application/json'}

  # GET /artworks
  # GET /artworks.json
  def index
    @artworks = Artwork.all
  end

  # GET /artworks/1
  # GET /artworks/1.json
  def show
  end

  # GET /artworks/new
  def new
    @artwork = Artwork.new
  end

  # GET /artworks/1/edit
  def edit
  end

  # POST /artworks
  # POST /artworks.json
  def create
    exsiting = Artwork.where(:source_file_fingerprint=>artwork_params[:source_file_fingerprint],
               :style_id=>artwork_params[:style_id], :status=>2).first
    
    if exsiting.nil?
      @artwork = Artwork.new(artwork_params)
    else
      @artwork = exsiting 
      @artwork.call_it_back!
    end

    respond_to do |format|
      if @artwork.save
        format.html { redirect_to @artwork, notice: 'Artwork was successfully created.' }
        format.json { render :show, status: :created, location: @artwork }
      else
        format.html { render :new }
        format.json { render json: @artwork.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artworks/1
  # PATCH/PUT /artworks/1.json
  def update
    respond_to do |format|
      if @artwork.update(artwork_params)
        format.html { redirect_to @artwork, notice: 'Artwork was successfully updated.' }
        format.json { render :show, status: :ok, location: @artwork }
      else
        format.html { render :edit }
        format.json { render json: @artwork.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artworks/1
  # DELETE /artworks/1.json
  def destroy
    @artwork.destroy
    respond_to do |format|
      format.html { redirect_to artworks_url, notice: 'Artwork was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artwork
      @artwork = Artwork.find(params[:id])
    end
    
    def set_style
      if params[:artwork][:style_id].blank?
        style = Style.fetch params[:artwork][:style][:fingerprint], params[:artwork][:style][:source]
        params[:artwork][:style_id] = style.id
      end
      params[:artwork][:style] = nil
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artwork_params
      params.require(:artwork).permit(:source_file, :style_id, :ext_arg,
         :source_file_fingerprint, :callback, style: [:fingerprint, :source])
    end
end
