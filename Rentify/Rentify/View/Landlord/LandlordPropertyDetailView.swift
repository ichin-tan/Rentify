//
//  LandlordPropertyDetailView.swift
//  Rentify
//
//  Created by CP on 12/03/25.
//

import SwiftUI

struct LandlordPropertyDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: PropertyViewModel
    
    @State var goToEditPropertyScreen = false
    @State var goToRequestScreen = false
    @State private var isShowAlert: Bool = false
    @State private var strAlertMessage: String = ""

    var body: some View {
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
                
                Text(self.viewModel.selectedProperty?.streetAddress ?? "Property Details")
                    .padding(.bottom, 10)
                    .padding(.trailing, 40)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 30))
            }
            .foregroundColor(.appAliceBlue)
            .background(Color.appBlue)
            .fontWeight(.bold)
            
            if let property = self.viewModel.selectedProperty {
                if property.imgUrl != "" {
                    AsyncImage(url: URL(string: property.imgUrl)) { image in
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
                
                HStack(spacing: 10) {
                    Text("Street Address:")
                        .foregroundColor(.appGrayBlue)
                        .fontWeight(.bold)
                        
                    Text(property.streetAddress)
                    
                    Spacer()
                }
                .padding([.leading, .trailing], 20)
                .padding(.top, 10)
                
                HStack(spacing: 10) {
                    Text("City:")
                        .foregroundColor(.appGrayBlue)
                        .fontWeight(.bold)
                        
                    Text(property.city)
                    
                    Spacer()
                }
                .padding([.leading, .trailing], 20)
                .padding(.top, 0)

                HStack(spacing: 10) {
                    Text("Country:")
                        .foregroundColor(.appGrayBlue)
                        .fontWeight(.bold)
                        
                    Text(property.country)
                    
                    Spacer()
                }
                .padding([.leading, .trailing], 20)
                .padding(.top, 0)
                
                HStack(spacing: 10) {
                    Text("Rent:")
                        .foregroundColor(.appGrayBlue)
                        .fontWeight(.bold)
                        
                    Text("$ \(String(format: "%.2f", property.rent))")
                    
                    Spacer()
                }
                .padding([.leading, .trailing], 20)
                .padding(.top, 0)
                
                if(property.rentedUserId == "") {
                    if(property.addedByLandlordId == FirebaseManager.shared.getCurrentUserUIdFromFirebase()) {
                        
                        if(property.isActivated) {
                            Button {
                                goToEditPropertyScreen = true
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(height: 50)
                                        .padding([.leading, .trailing], 20)
                                        .foregroundColor(.appBlue)

                                    Text("Edit Property")
                                        .foregroundColor(.appAliceBlue)
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                }
                            }
                            .padding(.top,5)
                            
                            Button {
                                goToRequestScreen = true
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(height: 50)
                                        .padding([.leading, .trailing], 20)
                                        .foregroundColor(.appBlue)

                                    Text("View Requests")
                                        .foregroundColor(.appAliceBlue)
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                }
                            }
                            .padding(.top,5)

                        }
                        
                        Button {
                            // I could make an alert here but for the sake of time lets just say there is an alert
                            self.viewModel.selectedProperty?.isActivated.toggle()
                            if let property = self.viewModel.selectedProperty {
                                FirebaseManager.shared.addOrUpdateProperty(property: property) { success in
                                    if (success) {
                                        strAlertMessage = property.isActivated ? "Property Activated!" : "Property Deactivated"
                                        isShowAlert = true
                                    } else {
                                        strAlertMessage = "Something went wrong!"
                                        isShowAlert = true
                                    }
                                }
                            } else {
                                strAlertMessage = "Coudn't get the current property!"
                                isShowAlert = true
                            }
                             
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(height: 50)
                                    .padding([.leading, .trailing], 20)
                                    .foregroundColor(.appBlue)

                                Text(property.isActivated ? "Deactivate" : "Activate")
                                    .foregroundColor(.appAliceBlue)
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                            }
                        }
                        .padding(.top,5)
                        
                    }
                } else {
                    if(property.addedByLandlordId == FirebaseManager.shared.getCurrentUserUIdFromFirebase()) {
                        if let tenant = viewModel.tenant {
                            VStack {
                                Text("Tenant Details")
                                    .font(.system(size: 25))
                                    .fontWeight(.bold)
                                    .padding(.top, 10)
                                
                                HStack(spacing: 10) {
                                    Text("Name:")
                                        .foregroundColor(.appGrayBlue)
                                        .fontWeight(.bold)
                                        
                                    Text(tenant.name)
                                    
                                    Spacer()
                                }
                                .padding([.leading, .trailing], 20)
                                .padding(.top, 10)
                                
                                HStack(spacing: 10) {
                                    Text("Email:")
                                        .foregroundColor(.appGrayBlue)
                                        .fontWeight(.bold)
                                        
                                    Text(tenant.email)
                                    
                                    Spacer()
                                }
                                .padding([.leading, .trailing], 20)
                                .padding(.top, 0)

                                HStack(spacing: 10) {
                                    Text("Contact:")
                                        .foregroundColor(.appGrayBlue)
                                        .fontWeight(.bold)
                                        
                                    Button() {
                                        guard let url = URL(string: "telprompt://\(tenant.contact)") else { return }
                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                    } label: {
                                        Text(tenant.contact)
                                            .foregroundColor(.appBlue)
                                            .fontWeight(.bold)
                                    }
                                    
                                    Spacer()
                                }
                                .padding([.leading, .trailing], 20)
                                .padding(.top, 0)
                            }
                            .padding(.top, 0)
                        }
                    }
                }
            }
            
            Spacer()
        }
        .onAppear() {
            if let property = self.viewModel.selectedProperty {
                self.viewModel.fetchTenant(userID: property.addedByLandlordId)
                if(property.rentedUserId != "") {
                    self.viewModel.fetchTenant(userID: property.rentedUserId)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appColumbiaBlue)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .alert(isPresented: $isShowAlert) {
            Alert(title: Text("Rentify"), message: Text("\(self.strAlertMessage)"),dismissButton: .default(Text("OK"), action: {
                print("Alert dismissed!")
            }))
        }
        .navigationDestination(isPresented: $goToEditPropertyScreen) {
            LandlordEditPropertyView(viewModel: self.viewModel)
        }
        .navigationDestination(isPresented: $goToRequestScreen) {
            LandlordPropertyRequestListView(viewModel: self.viewModel)
        }
    }
}

#Preview {
    LandlordPropertyDetailView(viewModel: PropertyViewModel())
}
