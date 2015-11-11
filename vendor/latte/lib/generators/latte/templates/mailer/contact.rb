class Contact
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  ##
  # Add other fields if you need
  attr_accessor :name,
                :email,
                #:email_confirmation,
                #:phone,
                :content

  validates :name, presence: true
  validates :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, if: Proc.new{ |o| o.email.present? }
  #validates :email, confirmation: true
  #validates :email_confirmation, presence: true
  #validates :phone, presence: true
  validates :content, presence: true

  def initialize attributes = {}
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def deliver
    AppMailer.contact(self).deliver_now
  end
end
