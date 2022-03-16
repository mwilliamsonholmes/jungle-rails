require 'rails_helper'

RSpec.feature "users can click the 'Add to Cart' button for a product on the home page and in doing so their cart increases by one", type: :feature, js: true do

  # SETUP
  before :each do
   @category = Category.create! name: 'Apparel'
 
   10.times do |n|
     @category.products.create!(
       name:  Faker::Hipster.sentence(3),
       description: Faker::Hipster.paragraph(4),
       image: open_asset('apparel3.jpg'),
       quantity: 10,
       price: 64.99
     )
   end
 end
 

 scenario "They click 'Add to Cart' and their cart increases from 0 to 1" do
  #ACT
  visit root_path
  
   # DEBUG / VERIFY
   save_screenshot
   expect(page).to have_css 'article.product', count: 10
   
   
   page.has_content?('My Cart (0)')

   first('.btn-primary').click
  #  expect(page).to have_css 'i.fa-shopping-cart', count: 1
  page.has_content?('My Cart (1)')
  end
  
end
