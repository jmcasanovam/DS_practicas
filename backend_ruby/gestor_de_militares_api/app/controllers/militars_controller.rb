class MilitarsController < ApplicationController
  def index
    @militares = Militar.where(usuario: params[:usuario])
    # @militares = Militar.all
    logger.info "Cargando militares para usuario: #{params[:usuario]}, Total: #{@militares.count}"
    render json: @militares
  end

  def create
    @militar = Militar.new(militar_params)##.merge(usuario: params[:usuario])
    if @militar.save
      render json: @militar, status: :created
    else
      render json: @militar.errors, status: :unprocessable_entity
    end
  end


  def update
    @militar = Militar.find_by(usuario: params[:usuario], nombre: params[:nombre])
    if @militar.update(militar_params)
      render json: @militar
    else
      render json: @militar.errors, status: :unprocessable_entity
    end
  end

  def destroy
    # militar = Militar.where(usuario: params[:usuario]).find_by(params[:nombre])
    militar = Militar.find_by(nombre: params[:nombre], usuario: params[:usuario])

    if militar.destroy
      head :ok
    else
      render json: { error: "Failed to delete" }, status: :unprocessable_entity
    end
  end



  private

  def militar_params
     params.require(:militar).permit(:nombre, :oficial, :usuario, :nombre_superior)
  end
end

  
