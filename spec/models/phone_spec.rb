require "rails_helper"

describe Phone do
  it "does not allow duplicate phone numbers per contact" do
    contact = Contact.create firstname: "Vuong",
      lastname: "Phan",
      email: "vuong@gmail.com"
    contact.phones.create phone_type: "home", phone: "01202017464"
    mobile_phone = contact.phones.build phone_type: "mobile",
      phone: "01202017464"
    mobile_phone.valid?
    expect(mobile_phone).not_to be_valid
  end

  it "allows two contacts to share a number phone" do
    contact = Contact.create firstname: "Vuong",
      lastname: "Phan",
      email: "vuong@gmail.com"
    contact.phones.create phone_type: "home", phone: "01202017464"
    other_contact = Contact.new
    other_phone = other_contact.phones.build phone_type: "home",
      phone: "01202017464"
    expect(other_phone).to be_valid
  end
end
