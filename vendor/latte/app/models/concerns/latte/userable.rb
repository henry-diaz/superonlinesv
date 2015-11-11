module Latte
  module Userable
    extend ActiveSupport::Concern

    included do
      devise :database_authenticatable,
             :omniauthable,
             :recoverable,
             :rememberable,
             :trackable,
             :registerable,
             :confirmable

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
      has_many :user_authorizations, dependent: :destroy

      ##
      # Paperclip image
      has_attached_file :image, styles: { medium: '410x410>', thumb: '205x205>' }, default_url: ActionController::Base.helpers.asset_path('latte/missing.png')
      validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
      attr_accessor :delete_image
      before_validation { self.image = nil if delete_image == '1' }
    end

    module ClassMethods

      def from_omniauth(auth, current_user)
        authorization = UserAuthorization.where(provider: auth.provider, uid: auth.uid.to_s).first_or_initialize
        authorization.token  = auth.credentials.try(:token).to_s
        authorization.secret = auth.credentials.try(:secret).to_s

        if authorization.user.blank?
          user = current_user || self.where('email = ?', auth['info']['email']).first
          if user.blank?
            user          = self.new
            user.password = ::Devise.friendly_token[0, 10]
            user.name     = auth.info.try(:name).to_s
            user.email    = auth.info.try(:email).to_s
            user.image    = URI.parse(auth.info.try(:image).to_s.gsub('http://', 'https://'))

            user.skip_confirmation!
            user.save(validate: false)
          end
          authorization.username = auth.info.try(:nickname).to_s
          authorization.user_id = user.id
          authorization.save
        end
        authorization.user
      end
    end
  end
end
