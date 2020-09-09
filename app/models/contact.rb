class Contact < ApplicationRecord
  belongs_to :telephone_book

  validates :name, presence: true
  validates :phone, presence: true,
                    uniqueness: { scope: :telephone_book_id }
end
