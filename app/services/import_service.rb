class ImportService
  require 'csv'
  attr_accessor :file, :telephone_book, :errors, :csv_contacts
  ALLOWED_ATTRIBUTES = %w[name phone].freeze

  def initialize(file, telephone_book)
    @file = file
    @telephone_book = telephone_book
    @errors = []
    @csv_contacts = CSV.read(file.path, headers: true)
  end

  def success?
    return if @errors.any?

    validate_duplicate
    validate_attribute

    if errors.present?
      false
    else
      true
    end
  end

  def import
    Contact.where.not(phone: csv_contacts['phone']).destroy_all
    csv_contacts.each do |row|
      contact = Contact.find_by(phone: row['phone'])
      params = row.to_hash
      if contact
        contact.update(params)
      else
        telephone_book.contacts.create(params)
      end
    end
  end

  private

  def validate_attribute
    @errors << 'Invalid headers' unless @csv_contacts.headers == ALLOWED_ATTRIBUTES
  end

  def validate_duplicate
    duplicate_contacts = csv_contacts.select { |row| csv_contacts['phone'].count(row['phone']) > 1 }
                                     .map { |contact| [contact['phone'], contact['name']] }

    @errors << { 'Number duplicate in contact' => duplicate_contacts }
  end
end
