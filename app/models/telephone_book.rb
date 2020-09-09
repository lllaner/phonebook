class TelephoneBook < ApplicationRecord
  require 'csv'

  belongs_to :user
  has_many :contacts, dependent: :destroy
  validates :title, presence: true

  def import(file)
    CSV.foreach(file, headers: true) do |row|
      params = row.to_hash
      if Contact.find_by(phone: params['phone'])
        Contact.update(params)
      else
        contacts.create(params)
      end
    end
  end
end
