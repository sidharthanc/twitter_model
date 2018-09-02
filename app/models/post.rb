
class Post < ActiveRecord::Base
    has_many :comments
    belongs_to :user
    delegate :name, to: :user, prefix: true
    validates :title, presence: true, length: {minimum: 5}
    mount_uploader :image, ImageUploader

end
