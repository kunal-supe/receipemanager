class Review < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :chef
  
 validates :body, presence: true,  length: { minimum: 10, maximum: 150}
end  