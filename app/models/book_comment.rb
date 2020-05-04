class BookComment < ApplicationRecord
  belongs_to :user #Userモデルと1対Nの関係
  belongs_to :book

  validates :comment, presence: true #コメント空白時
end
