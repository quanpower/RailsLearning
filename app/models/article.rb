class Article < ActiveRecord::Base
  has_many :comments #has many comments
  validates :title, presence: true,
            length: { minimum: 5 }
end
