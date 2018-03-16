class User < ApplicationRecord
  attr_reader :remember_token, :activation_token, :reset_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true, numericality: {only_integer: true}
  validates :name, presence: true, length: {maximum: Settings.name.maximum}
  validates :address, presence: true, length:
    {maximum: Settings.address.maximum}
end
