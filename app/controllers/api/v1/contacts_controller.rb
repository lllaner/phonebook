class Api::V1::ContactsController < Api::ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_token
  before_action :find_telephone_book, only: :create
  before_action :find_contact, only: %i[show destroy edit update]

  def create
    @contact = @telephone_book.contacts.new(contact_params)
    if @contact.save
      render json: @contact
    else
      render json: { error: 'Invalid data' }
    end
  end

  def update
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: { error: 'Invalid data' }
    end
  end

  def show
    render json: @contact
  end

  def destroy
    @contact.destroy
    render json: @contact
  end

  private

  def find_contact
    @contact = Contact.find(params[:id])
  end

  def find_telephone_book
    @telephone_book = TelephoneBook.find(params[:telephone_book_id])
  end

  def contact_params
    params.require(:contact).permit(:id, :name, :phone, :telephone_book_id)
  end
end
