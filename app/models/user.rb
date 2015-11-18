class User < ActiveRecord::Base
  include Latte::Userable

  attr_encrypted :credit_card, :key => '61710f3402fa613695a08905a02139d2b6432ee0293772ce7bca9687218abc15d8ce159bdfd6ab213a6ebd92e546d644402bbc02c4628aec01314752ee4ac8a7'

  validates :username, presence: true, uniqueness: true
  validates :credit_card, presence: true

  has_many :orders, dependent: :destroy
end
