module Latte
  module Adminable
    extend ActiveSupport::Concern

    included do
      devise :database_authenticatable,
             :recoverable,
             :rememberable,
             :trackable

      ##
      # Validations
      validates :name,     presence: true
      validates :email,    presence: true
      validates :email,    uniqueness: { case_sensitive: false }, if: Proc.new{ |o| o.email.present? }
      validates :email,    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, if: Proc.new{ |o| o.email.present? }
      validates :password, presence: true, confirmation: true, on: :create
      validates :password, presence: true, confirmation: true, if: Proc.new{ |o| o.password.present? }, on: :update

      ##
      # Associations
      has_one :author
    end
  end
end
