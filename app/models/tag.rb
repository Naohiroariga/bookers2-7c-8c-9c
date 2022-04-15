class Tag < ApplicationRecord
  has_many :book_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :books, through: :book_tags

  scope :merge_books, -> (tags){ }

  def self.looks_tag(search, word)
      Tag.where("name LIKE?", "#{word}")
  end

end
