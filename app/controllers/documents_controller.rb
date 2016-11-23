class DocumentsController < ApplicationController

  def create
    @document = Document.new(document_params)
    @document.save
    redirect_to search_path
  end


  def show
    @document = Document.find(params[:id])
  end

  def new
    @document = Document.new
  end

  def searchs
    if params[:q].nil?
      @documents = []
    else
      @documents = Document.search params[:q]
    end
    # byebug


  end

  private
    def document_params
       params.require(:document).permit :title, :document_attachment
    end

end
