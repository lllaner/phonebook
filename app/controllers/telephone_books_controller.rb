class TelephoneBooksController < ApplicationController
  before_action :find_telephone_book, only: %i[show edit update destroy import]

  def index
    @telephone_books = TelephoneBook.all
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
    @telephone_book.import(params[:file])
  end


  private

  def find_telephone_book
    @telephone_book = TelephoneBook.find(params[:id])
  end

  def telephone_book_params
    params.require(:telephone_book).permit(:title, :file)
  end
end
