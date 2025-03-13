//
//  LandlordAddPropertyView.swift
//  Rentify
//
//  Created by CP on 11/03/25.
//

import SwiftUI

struct LandlordAddPropertyView: View {
    
    @State private var strPropertyImage: String = "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg"
    @State private var strStreetAddress: String = ""
    @State private var strCity: String = ""
    @State private var strCountry: String = ""
    @State private var strRent: String = ""
    @State private var isShowAlert: Bool = false
    @State private var strAlertMessage: String = ""
    private var locManager = LocManager.getInstance()

    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Text("Add Property")
                    .padding(.bottom, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.appBlue)
                    .font(.system(size: 30))
                    .foregroundColor(.appAliceBlue)
                    .fontWeight(.bold)
            }
            
            ScrollView {
                propertyImageField
                
                if(strPropertyImage != "") {
                    propertyImage
                }
                
                streetAddressField
                
                cityField
                
                countryField
                
                rentField
                
                fetchCurrentLocationButton
                
                addPropertyButton
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appColumbiaBlue)
        .alert(isPresented: $isShowAlert) {
            Alert(title: Text("Rentify"), message: Text("\(self.strAlertMessage)"),dismissButton: .default(Text("OK"), action: {
                print("Alert dismissed!")
            }))
        }
    }
    
    var propertyImageField: some View {
        TextField("Property Image URL (Optional)", text: $strPropertyImage)
            .frame(height: 25)
            .font(.system(size: 20))
            .foregroundColor(.appGrayBlue)
            .padding(10)
            .background(.appAliceBlue)
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.appGrayBlue, lineWidth: 1)
            }
            .padding([.leading, .trailing], 20)
            .padding(.top, 20)
            .autocorrectionDisabled()
            .autocapitalization(.none)
    }
    
    var propertyImage: some View {
        AsyncImage(url: URL(string: strPropertyImage)) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.appGrayBlue, lineWidth: 1)
                }
                .padding([.leading, .trailing], 20)
                .padding(.top, 5)
        } placeholder: {
            RoundedRectangle(cornerRadius: 10)
                .fill(.appAliceBlue)
                .frame(height: 200)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.appGrayBlue, lineWidth: 1)
                }
                .padding([.leading, .trailing], 20)
                .padding(.top, 5)
                .overlay {
                    ProgressView()
                }
        }
    }
    
    var streetAddressField: some View {
        TextField("Street Address", text: $strStreetAddress)
            .frame(height: 25)
            .font(.system(size: 20))
            .foregroundColor(.appGrayBlue)
            .padding(10)
            .background(.appAliceBlue)
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.appGrayBlue, lineWidth: 1)
            }
            .padding([.leading, .trailing], 20)
            .padding(.top,5)
            .autocorrectionDisabled()
            .autocapitalization(.none)
    }
    
    var cityField: some View {
        TextField("City", text: $strCity)
            .frame(height: 25)
            .font(.system(size: 20))
            .foregroundColor(.appGrayBlue)
            .padding(10)
            .background(.appAliceBlue)
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.appGrayBlue, lineWidth: 1)
            }
            .padding([.leading, .trailing], 20)
            .padding(.top,5)
            .autocorrectionDisabled()
            .autocapitalization(.none)
    }
    
    var countryField: some View {
        TextField("Country", text: $strCountry)
            .frame(height: 25)
            .font(.system(size: 20))
            .foregroundColor(.appGrayBlue)
            .padding(10)
            .background(.appAliceBlue)
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.appGrayBlue, lineWidth: 1)
            }
            .padding([.leading, .trailing], 20)
            .padding(.top,5)
            .autocorrectionDisabled()
            .autocapitalization(.none)
    }
    
    var rentField: some View {
        TextField("Rent", text: $strRent)
            .frame(height: 25)
            .keyboardType(.decimalPad)
            .font(.system(size: 20))
            .foregroundColor(.appGrayBlue)
            .padding(10)
            .background(.appAliceBlue)
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.appGrayBlue, lineWidth: 1)
            }
            .padding([.leading, .trailing], 20)
            .padding(.top,5)
            .autocorrectionDisabled()
            .autocapitalization(.none)
    }
    
    var addPropertyButton: some View {
        Button {
            self.addProperty()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 50)
                    .padding([.leading, .trailing], 20)
                    .foregroundColor(.appBlue)

                Text("Add")
                    .foregroundColor(.appAliceBlue)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
            }
        }
        .padding(.top,15)
    }
    
    var fetchCurrentLocationButton: some View {
        Button {
            locManager.getPlaceThroughGeocoding { place in
                if let address = place {
                    if locManager.currentLocation.coordinate.latitude == 0.0 && locManager.currentLocation.coordinate.longitude == 0.0 {
                        strAlertMessage = "Couldnt't find address!"
                        isShowAlert = true

                    } else {
                        print(address)
                        strCity = place?.subLocality ?? ""
                        strCountry = place?.country ?? ""
                        strStreetAddress = place?.thoroughfare ?? ""
                    }
                } else {
                    strAlertMessage = "Couldnt't find address!"
                    isShowAlert = true
                }
            }

        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 50)
                    .padding([.leading, .trailing], 20)
                    .padding(.top, 0)
                    .foregroundColor(.appBlue)

                Text("Fill Current Address")
                    .foregroundColor(.appAliceBlue)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
            }
        }
        .padding(.top,5)
    }
    
    private func isValidated() -> Bool {
        var isValidate = true
        if(strStreetAddress.isEmpty) {
            isValidate = false
            strAlertMessage = "Street Address cannot be empty!"
            isShowAlert = true
        } else if(strCity.isEmpty) {
            isValidate = false
            strAlertMessage = "City cannot be empty!"
            isShowAlert = true
        } else if(strCountry.isEmpty) {
            isValidate = false
            strAlertMessage = "Country cannot be empty!"
            isShowAlert = true
        } else if(strRent.isEmpty || (Double(strRent) ?? 0.0) == 0.0) {
            strAlertMessage = "Rent cannot be empty!"
            isShowAlert = true
            isValidate = false
        }
        return isValidate
    }
    
    private func addProperty() {
        if(isValidated()) {
            let address = "\(self.strStreetAddress), \(self.strCity), \(self.strCountry)"
            locManager.getLocationFrom(address: address) { location in
                if let location = location {
                    let property = Property(id: UUID().uuidString, imgUrl: strPropertyImage, streetAddress: strStreetAddress, city: strCity, country: strCountry, rent: Double(strRent) ?? 0.0, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, address: address, addedByLandlordId: FirebaseManager.shared.getCurrentUserUIdFromFirebase() ?? "", isActivated: true, shortListedTenantIds: [], requestedTenantIds: [])
                    FirebaseManager.shared.addOrUpdateProperty(property: property) { success in
                        if(success) {
                            strAlertMessage = "Property added successfully!"
                            isShowAlert = true
                            crearFields()
                        } else {
                            strAlertMessage = "Something went wrong while adding property!"
                            isShowAlert = true
                        }
                    }
                } else {
                    strAlertMessage = "Couldn't add property because geocoding didn't work!"
                    isShowAlert = true
                }
            }
        }
    }
    
    private func crearFields() {
        strPropertyImage = ""
        strStreetAddress = ""
        strCity = ""
        strCountry = ""
        strRent = ""
    }
}

#Preview {
    LandlordAddPropertyView()
}
