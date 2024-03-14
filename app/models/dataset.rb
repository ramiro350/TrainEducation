class Dataset < ApplicationRecord
  belongs_to :user
  has_one_attached :arquivo
end