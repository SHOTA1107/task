class Todo < ApplicationRecord
  validates :name, presence: true
  validate :validate_name_not_including_comma

  belongs_to :user

  private
  def validate_name_not_including_comma
    errors.add(:name, 'カンマを含めることはできません') if name&.include?(',')
  end
end
