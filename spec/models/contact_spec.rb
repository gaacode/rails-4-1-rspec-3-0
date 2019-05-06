require "rails_helper"

describe Contact do
  it "is valid with a firstname, lastname and email" do
    contact = Contact.new firstname: "Vuong",
      lastname: "Phan",
      email: "vuongpv@ominext.com"
    expect(contact).to be_valid
  end

  it "is invalid without a firstname" do
    contact = Contact.new firstname: nil,
      lastname: "Phan",
      email: "vuongpv@ominext.com"
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end

  it "is invalid without a lastname" do
    contact = Contact.new firstname: "Vuong",
      lastname: nil,
      email: "vuongpv@ominext.com"
    contact.valid?
    expect(contact.errors[:lastname]).to include("can't be blank")
  end

  it "is invalid without an email address" do
    contact = Contact.new firstname: "Vuong",
      lastname: "Phan",
      email: nil
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    Contact.create firstname: "Vuong",
      lastname: "Phan",
      email: "vuongpv@ominext.com"
    contact = Contact.new firstname: "Long",
      lastname: "Phan",
      email: "vuongpv@ominext.com"
    contact.valid?
    expect(contact.errors[:email]).to include("has already been taken")
  end

  it "returns a contact's full name as a string" do
    contact = Contact.new firstname: "Vuong",
      lastname: "Phan",
      email: "vuongpv@ominext.com"
    expect(contact.name).to eq "Vuong Phan"
  end

  it "returns a sorted array of results that match" do
    vuong = Contact.create firstname: "Phan",
      lastname: "Vuong",
      email: "vuongpv@ominext.com"
    long = Contact.create firstname: "Phan",
      lastname: "Long",
      email: "longpv@ominext.com"
    van = Contact.create firstname: "Phan",
      lastname: "Van",
      email: "vanpv@ominext.com"
    
    expect(Contact.by_letter("V")).to eq [van, vuong]
  end

  it "omits results that do not match" do
    vuong = Contact.create firstname: "Phan",
      lastname: "Vuong",
      email: "vuongpv@ominext.com"
    long = Contact.create firstname: "Phan",
      lastname: "Long",
      email: "longpv@ominext.com"
    van = Contact.create firstname: "Phan",
      lastname: "Van",
      email: "vanpv@ominext.com"
    
    expect(Contact.by_letter("V")).not_to include long
  end
end
