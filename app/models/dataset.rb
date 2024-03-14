class Dataset < ApplicationRecord
  has_one :user
  has_one_attached :arquivo
end