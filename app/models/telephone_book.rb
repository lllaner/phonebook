class TelephoneBook < ApplicationRecord
  belongs_to :user
  has_many :contacts, dependent: :destroy
  validates :title, presence: true
end
