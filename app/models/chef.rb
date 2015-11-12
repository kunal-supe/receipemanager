class Chef < ActiveRecord::Base
  before_save {self.email = email.downcase}
  has_many :recipes
  has_many :likes
  validates :chefname, presence: true, length: { minimum: 3, maximum: 40}
  VALID_EMAIL_REGEX = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
  validates :email, presence: true, length: {maximum: 110}, 
                    uniqueness: {case_sensitive: false},
                    format: {with: VALID_EMAIL_REGEX}
end