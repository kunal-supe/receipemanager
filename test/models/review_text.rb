require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.create(chefname: "Mr. Donald", email: "donald@gmail.com")
    @recipe = @chef.recipes.build(name: "Veg Crisp", summary: "this is best recipe ever", 
              description: "Heat oil, add vegetables, chop onions, put chillies, add flour with water, mix it & deep fry. ")
    @review = @recipe.reviews.build(body: "Good recipe")          
  end
  
 test "recipe should be valid" do
    assert @review.valid?
  end
  
  test "review_id should be present" do
    @recipe.review = nil
    assert_not @review.valid?
  end   

end  