class Review < ActiveRecord::Base
	validates :review, presence: true, length: { minimum: 5, maximum: 500 }
	belongs_to :chef
	belongs_to :recipe
end