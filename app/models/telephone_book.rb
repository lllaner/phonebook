class TelephoneBook < ApplicationRecord
  require 'csv'

  belongs_to :user
  has_many :contacts, dependent: :destroy
  validates :title, presence: true

  def import(file)
    csv_contacts = CSV.read(file.path, headers: true)
    Contact.where.not(phone: csv_contacts['phone']).destroy_all
    csv_contacts.each do |row|
      contact = Contact.find_by(phone: row['phone'])
      params = row.to_hash

      if contact
        contact.update(params)
      else
        contacts.create(params)
      end
    end
  end
end
