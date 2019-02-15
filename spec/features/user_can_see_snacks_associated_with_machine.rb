require 'rails_helper'

feature "When a user visits the vending machine show page" do
  it "they see the name and price of all snacks" do

    owner = Owner.create(name: "Sam's Snacks")
    snack_1 = Snack.create(name: "White Castle Burger", price: 3.50)
    snack_2 = Snack.create(name: "Pop Rocks", price: 1.50)
    snack_3 = Snack.create(name: "Flaming Hot Cheetos", price: 2.50)
    dons  = owner.machines.create(location: "Don's Mixed Drinks", snacks: [snack_1, snack_2, snack_3])

    visit machine_path(dons)

    expect(page).to have_content(snack_1.name)
    expect(page).to have_content("Price: #{snack_1.price}")
    expect(page).to have_content(snack_2.name)
    expect(page).to have_content("Price: #{snack_2.price}")
    expect(page).to have_content(snack_3.name)
    expect(page).to have_content("Price: #{snack_3.price}")
  end

  it "shows me average price for snacks in that machine" do

    owner = Owner.create(name: "Sam's Snacks")
    snack_1 = Snack.create(name: "White Castle Burger", price: 3.50)
    snack_2 = Snack.create(name: "Pop Rocks", price: 1.50)
    snack_3 = Snack.create(name: "Flaming Hot Cheetos", price: 2.50)
    dons  = owner.machines.create(location: "Don's Mixed Drinks", snacks: [snack_1, snack_2, snack_3])

    visit machine_path(dons)

    within "#average-price"

    expect(page).to have_content(2.5)
  end

end
