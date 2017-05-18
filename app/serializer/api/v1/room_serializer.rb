class Api::V1::RoomSerializer < Api::V1::BaseSerializer
	attributes :id, :name,  :slug, :created_at, :updated_at

	has_many :messages, dependent: :destroy
  has_many :users, through: :messages

  def created_at
    object.created_at.in_time_zone.iso8601 if object.created_at
  end

  def updated_at
    object.updated_at.in_time_zone.iso8601 if object.created_at
  end
end