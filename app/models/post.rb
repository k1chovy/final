class Post < ApplicationRecord
  belongs_to :user

  # Kết nối với ActiveStorage
  has_one_attached :image
  has_many :comments, dependent: :destroy
  # Xác thực
  validates :title, presence: { message: "Title can't be blank" }
  validates :content, presence: { message: "Content can't be blank" }
end
