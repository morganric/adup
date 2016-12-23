class Ad < ActiveRecord::Base

belongs_to :user
belongs_to :website

mount_uploader :image, ImageUploader

end
