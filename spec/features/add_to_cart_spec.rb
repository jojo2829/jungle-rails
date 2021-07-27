require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  
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

  # comment out "before_filter :authorize" in carts_controller before doing test
  scenario "users can click the 'Add to Cart' button for a product on the home page" do
    visit root_path

    click_on "Add"

    click_on "My Cart"

    sleep(3)

    save_screenshot

    expect(page).to have_css '.cart-show'
  end

  scenario "Add to Cart - product increase by one" do
    visit root_path

    expect(page).to have_content "My Cart (0)"

    click_on "Add"

    sleep(3)

    save_screenshot

    expect(page).to have_content "My Cart (1)"
  end

end
