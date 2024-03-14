class DatasetsController < AuthenticatedController
  before_action :set_dataset, except: [:index, :new, :create]
  include ActiveStorage::SetCurrent

  def index
    @datasets = Dataset.all
  end
  
  def new
    @dataset = Dataset.new
  end

  def create
    @dataset = Dataset.new(dataset_params)
    @dataset.user = current_user

    if @dataset.save
      flash[:success] = "Dataset cadastrado."
      redirect_to datasets_path
    else
      flash[:error] = 'Ocorreu um erro.'
      # redirect_to 
      render :new
    end
  end

  def show
  end

  def edit
    if @dataset.update(dataset_params)
      redirect_to dataset_path(@dataset)
    else
      render :edit
    end
  end

  def destroy
    @dataset.delete

    if @dataset.nil?
      flash[:error] = 'Ocorreu um erro.'
    end
    
    redirect_to datasets_path
  end

  private

  def set_dataset
    @dataset = Dataset.find(params[:id])
  end

  def dataset_params
    params.require(:dataset).permit(:nome, :descricao, :arquivo)
  end
end