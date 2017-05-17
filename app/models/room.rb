class Room < ApplicationRecord
	has_many :messages, dependent: :destroy
  has_many :users, through: :messages
  validates :name, presence: true, uniqueness: true, case_sensitive: false
  before_validation :slugify

  def to_param
    self.slug
  end

  def slugify
    self.slug = self.name.parameterize
  end
end
