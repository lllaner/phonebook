class TelephoneBooksController < ApplicationController
  before_action :find_telephone_book, only: %i[show edit update destroy import]
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_telephone_book_not_found

  def index
    @telephone_books = current_user.telephone_books
  end

  def new
    @telephone_book = current_user.telephone_books.new
  end

  def create
    @telephone_book = current_user.telephone_books.new(telephone_book_params)
    if @telephone_book.save
      redirect_to telephone_book_path(@telephone_book)
    else
      render :new
    end
  end

  def update
    if @telephone_book.update(telephone_book_params)
      redirect_to root_path, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @telephone_book.destroy
    redirect_to root_path
  end

  def import
    import_service = ImportService.new(params[:file], @telephone_book)
    flash_options = if import_service.success?
                      import_service.import
                      { notice: 'Import completed success' }
                    else
                      { alert: import_service.errors }
                    end
    redirect_to telephone_book_path(@telephone_book), flash_options
  end

  private

  def rescue_with_telephone_book_not_found
    render plain: 'Telephone book not found'
  end


  def find_telephone_book
    @telephone_book = TelephoneBook.find(params[:id])
  end

  def telephone_book_params
    params.require(:telephone_book).permit(:title, :file)
  end
end
