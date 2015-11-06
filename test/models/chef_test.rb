require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
    def setup
      @chef = Chef.new(chefname: "Mr. Donald", email: "donald@gmail.com")
    end
    
    test "chef should be valid" do
      assert @chef.valid?
    end
    
    test "chefname should be present" do
      @chef.chefname = " "
      assert_not @chef.valid?
    end  
    
    test "name length should be too long" do
      @chef.chefname = "a" * 41
      assert_not @chef.valid?
    end
  
    test "name length should be too short" do
      @chef.chefname = "aa"
      assert_not @chef.valid?
    end
    
    test "email must be present" do
      @chef.email = " "
      assert_not @chef.valid?
    end  
    
    test "email lenght shoul be out of bound" do
      @chef.email = "a" * 101 + "@example.com"
      assert_not @chef.valid?
    end  
    
    test "email must be unique" do
      dup_chef = @chef.dup
      dup_chef.email = @chef.email.upcase
      @chef.save
      assert_not dup_chef.valid?
    end  
  
    test "email address should accept valid" do
      valid_addresses = %w[user@ee.com R_TDD-DS@eee.helo.org user@example.com first.last@example.com laura+joe@example.com]
      valid_addresses.each do |va|
        @chef.email = va
        assert @chef.valid?, '#{va.inspect} should be valid'
      end
        
    end  
    
      
    test "email address should reject invalid" do
      invalid_addresses = %w[user@example,com user_shs.orf eee@i_l.com]
      invalid_addresses.each do |ia|
        @chef.email = ia
        assert_not @chef.valid?, '#{ia.inspect} should be valid'
      end
    end  
end  