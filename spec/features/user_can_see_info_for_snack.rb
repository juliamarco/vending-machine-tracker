require 'rails_helper'

feature "When a user visits the snack show page" do
  it "they see the info of that snack" do

    owner_1 = Owner.create(name: "Sam's Snacks")
    owner_2 = Owner.create(name: "Molly's Snacks")
    snack_1 = Snack.create(name: "White Castle Burger", price: 3.50)
    snack_2 = Snack.create(name: "Pop Rocks", price: 1.50)
    snack_3 = Snack.create(name: "Flaming Hot Cheetos", price: 2.50)

    dons = owner_1.machines.create(location: "Don's Mixed Drinks", snacks: [snack_1, snack_3])
    molly = owner_2.machines.create(location: "Don's Mixed Drinks", snacks: [snack_1, snack_2, snack_3])

    visit snack_path(snack_1)

    expect(page).to have_content(snack_1.name)
    expect(page).to have_content("Price: #{snack_1.price}")

    within "#owner-#{owner_1.id}"
    expect(page).to have_content(owner_1.name)
    expect(page).to have_content("Quantity: 2")
    expect(page).to have_content("Average price: 3")


    expect(page).to_not have_content(owner_2.name)

    within "#owner-#{owner_2.id}"
    expect(page).to have_content(owner_2.name)
    expect(page).to have_content("Quantity: 3")
    expect(page).to have_content("Average price: 2.5")

    expect(page).to_not have_content(owner_1.name)

  end

end
