class TelephoneBook < ApplicationRecord
  require 'csv'

  belongs_to :user
  has_many :contacts, dependent: :destroy
  validates :title, presence: true

  def import(file)
    CSV.foreach(file, headers: true) do |row|
      params = row.to_hash
      contact = contacts.find_by(phone: params['phone'])
      if contact
        contact.update(params)
      else
        contacts.create(params)
      end
    end
  end
end
