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
                .padding(.top, 10)
        } placeholder: {
            RoundedRectangle(cornerRadius: 10)
                .fill(.appAliceBlue)
                .frame(height: 200)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.appGrayBlue, lineWidth: 1)
                }
                .padding([.leading, .trailing], 20)
                .padding(.top, 10)
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
            .padding(.top, 10)
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
            .padding(.top, 10)
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
            .padding(.top, 10)
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
            .padding(.top, 10)
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
                    .padding(.top, 20)
                    .foregroundColor(.appBlue)

                Text("ADD")
                    .padding(.top, 20)
                    .foregroundColor(.appAliceBlue)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
            }
        }
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
            isValidate = false
            strAlertMessage = "Rent cannot be empty!"
            isShowAlert = true
        }
        return isValidate
    }
    
    private func addProperty() {
        if(isValidated()) {
            
        }
    }
}

#Preview {
    LandlordAddPropertyView()
}
