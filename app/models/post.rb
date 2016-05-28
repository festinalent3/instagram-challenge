class Post < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "500x500>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
