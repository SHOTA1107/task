class Todo < ApplicationRecord
  validates :name, presence: true
  validate :validate_name_not_including_comma

  belongs_to :user
  has_one_attached :image
  scope :recent, -> { order(created_at: :desc)}

  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  private
  def validate_name_not_including_comma
    errors.add(:name, 'カンマを含めることはできません') if name&.include?(',')
  end
end
