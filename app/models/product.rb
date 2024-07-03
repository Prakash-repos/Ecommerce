class Product < ApplicationRecord
	has_many :line_items, dependent: :destroy
	has_one_attached :image

	def image_url
		if self.image.attached?
			self.image
		else
			"https://cdn5.vectorstock.com/i/1000x1000/05/74/cream-or-gel-bottle-empty-cosmetic-product-vector-12660574.jpg"
		end
	end
end
