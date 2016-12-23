class Website < ActiveRecord::Base

belongs_to :user
has_many :ads

mount_uploader :image, ImageUploader

end
