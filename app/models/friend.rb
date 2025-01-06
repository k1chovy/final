class Friend < ApplicationRecord
    has_one_attached :featured_image
    has_rich_text :description
    validates :full_name, presence: true
    validates :email, presence: true
    validates :phone, presence: true
    validates :facebook, presence: true
    validates :description, presence: true
    validates :featured_image, presence: true
end
