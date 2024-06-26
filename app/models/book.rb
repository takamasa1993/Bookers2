class Book < ApplicationRecord
  belongs_to :user
  def author
    user.name
  end
  
  def description
    body
  end
  
  def get_image
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    image
  end
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
end
