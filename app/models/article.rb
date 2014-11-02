class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy #has many comments,dependent，依赖，删除文章会同时删除文章中的评论。
  validates :title, presence: true,
            length: { minimum: 5 }
  mount_uploader :article_image, ArticleImageUploader
end
