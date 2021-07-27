require 'rails_helper'

RSpec.feature "users can navigate from the home page to the product detail page by clicking on a product", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

    1.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Click into see product details" do
    visit root_path

    click_on "Details"

    sleep(5)

    save_screenshot

    expect(page).to have_css 'article.product-detail'
  end

end
