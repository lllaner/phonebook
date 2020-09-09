class Api::V1::TelephoneBooksController < Api::ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_token
  before_action :find_telephone_book, only: %i[show destroy edit update]

  def index
    render json: @user.telephone_books
  end

  def new
    @telephone_book = TelephoneBook.new
  end

  def create
    @telephone_book = TelephoneBook.new(telephone_book_params)
    if @telephone_book.save
      render json: @telephone_book
    else
      render json: {error: 'Invalid data'}
    end
  end

  def update
    if @telephone_book.update
      render json: @telephone_book
    else
      render json: { error: 'Invalid data' }
    end
  end

  def show
    render json: @telephone_book.contacts
  end

  def destroy
    @telephone_book.destroy
    render json: @telephone_book
  end

  def import
    @telephone_book.import(params[:file])
  end

  private

  def telephone_book_params
    params.require(:telephone_book).permit(:title, :id, :file)
  end

  def find_telephone_book
    @telephone_book = TelephoneBook.find(params[:id])
  end
end
