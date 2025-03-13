//
//  LandlordEditProfileView.swift
//  Rentify
//
//  Created by CP on 12/03/25.
//

import SwiftUI

struct LandlordEditPropertyView: View {
    @State private var strPropertyImage: String = "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg"
    @State private var strStreetAddress: String = ""
    @State private var strCity: String = ""
    @State private var strCountry: String = ""
    @State private var strRent: String = ""
    @State private var isShowAlert: Bool = false
    @State private var strAlertMessage: String = ""
    private var locManager = LocManager.getInstance()
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: PropertyViewModel
    
    init(viewModel: PropertyViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left.square.fill")
                            .font(.system(size: 25))
                            .padding(.bottom, 5)
                    }
                    .padding(.leading, 15)
                    
                    Text("Edit Property")
                        .padding(.bottom, 10)
                        .padding(.trailing, 40)
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 30))
                }
                .foregroundColor(.appAliceBlue)
                .background(Color.appBlue)
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
                
                editPropertyButton
                
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
        .onAppear() {
            self.strPropertyImage = self.viewModel.selectedProperty?.imgUrl ?? ""
            self.strStreetAddress = self.viewModel.selectedProperty?.streetAddress ?? ""
            self.strCity = self.viewModel.selectedProperty?.city ?? ""
            self.strCountry = self.viewModel.selectedProperty?.country ?? ""
            self.strRent = String(self.viewModel.selectedProperty?.rent ?? 0)
        }
        .navigationBarBackButtonHidden(true)
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
    
    var editPropertyButton: some View {
        Button {
            self.editProperty()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 50)
                    .padding([.leading, .trailing], 20)
                    .foregroundColor(.appBlue)

                Text("Edit")
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

                Text("FILL CURRENT ADDRESS")
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
    
    private func editProperty() {
        if(isValidated()) {
            let address = "\(self.strStreetAddress), \(self.strCity), \(self.strCountry)"
            locManager.getLocationFrom(address: address) { location in
                if let location = location {
                    if let previousProperty = self.viewModel.selectedProperty {
                        let property = Property(id: previousProperty.id, imgUrl: strPropertyImage, streetAddress: strStreetAddress, city: strCity, country: strCountry, rent: Double(strRent) ?? 0.0, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, address: address, addedByLandlordId: previousProperty.addedByLandlordId, isActivated: true, shortListedTenantIds: previousProperty.shortListedTenantIds, requestedTenantIds: previousProperty.requestedTenantIds)
                        
                        FirebaseManager.shared.addOrUpdateProperty(property: property) { success in
                            if(success) {
                                strAlertMessage = "Property updated successfully!"
                                self.viewModel.selectedProperty = property
                                isShowAlert = true
                            } else {
                                strAlertMessage = "Something went wrong while updating property!"
                                isShowAlert = true
                            }
                        }
                    } else {
                        strAlertMessage = "Something went wrong while updating property!"
                        isShowAlert = true
                    }
                } else {
                    strAlertMessage = "Couldn't update property because geocoding didn't work!"
                    isShowAlert = true
                }
            }
        }
    }
}

#Preview {
    LandlordEditPropertyView(viewModel: PropertyViewModel())
}
