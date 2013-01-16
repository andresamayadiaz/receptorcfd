class ComprobantesController < ApplicationController
  # GET /comprobantes
  # GET /comprobantes.json
  def index
    @comprobantes = Comprobante.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comprobantes }
    end
  end

  # GET /comprobantes/1
  # GET /comprobantes/1.json
  def show
    @comprobante = Comprobante.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comprobante }
    end
  end

  # GET /comprobantes/new
  # GET /comprobantes/new.json
  def new
    @comprobante = Comprobante.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comprobante }
    end
  end

  # GET /comprobantes/1/edit
  def edit
    @comprobante = Comprobante.find(params[:id])
  end

  # POST /comprobantes
  # POST /comprobantes.json
  def create
    @comprobante = Comprobante.new(params[:comprobante])

    respond_to do |format|
      if @comprobante.save
        format.html { redirect_to @comprobante, notice: 'Comprobante was successfully created.' }
        format.json { render json: @comprobante, status: :created, location: @comprobante }
      else
        format.html { render action: "new" }
        format.json { render json: @comprobante.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comprobantes/1
  # PUT /comprobantes/1.json
  def update
    @comprobante = Comprobante.find(params[:id])

    respond_to do |format|
      if @comprobante.update_attributes(params[:comprobante])
        format.html { redirect_to @comprobante, notice: 'Comprobante was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comprobante.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comprobantes/1
  # DELETE /comprobantes/1.json
  def destroy
    @comprobante = Comprobante.find(params[:id])
    @comprobante.destroy

    respond_to do |format|
      format.html { redirect_to comprobantes_url }
      format.json { head :no_content }
    end
  end
end
