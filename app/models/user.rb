class User < ApplicationRecord
  has_secure_password
  validates_confirmation_of :password

  has_many :parties, dependent: :destroy, foreign_key: :host_id
  has_many :party_viewers, through: :parties
  has_many :user_friends, dependent: :destroy
  has_many :friends, through: :user_friends

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password_confirmation, presence: true

  def invites
    id = self.id
    Party.joins(:party_viewers).where(party_viewers: { viewer_id: id })
  end
end
