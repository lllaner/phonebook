class ContactsController < ApplicationController
  before_action :find_telephone_book, only: %i[new create]
  before_action :find_contact, only: %i[destroy show edit update]
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_contact_not_found

  def new
    @contact = @telephone_book.contacts.new
  end

  def create
    @contact = @telephone_book.contacts.new(contact_params)
    if @contact.save
      redirect_to contact_path(@contact)
    else
      render :new
    end
  end

  def update
    if @contact.update(contact_params)
      redirect_to telephone_book_path(@contact.telephone_book), notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @contact.destroy
    redirect_to telephone_book_path(@contact.telephone_book)
  end

  private

  def rescue_with_contact_not_found
    render plain: 'Contact not found'
  end

  def find_telephone_book
    @telephone_book = TelephoneBook.find(params[:telephone_book_id])
  end

  def find_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :phone)
  end

end
