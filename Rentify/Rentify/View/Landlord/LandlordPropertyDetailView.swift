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
    
    @State var goToEditProfileScreen = false
    
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
                
                if(property.addedByLandlordId == FirebaseManager.shared.getCurrentUserUIdFromFirebase()) {
                    Button {
                        // Edit Property Button
                        goToEditProfileScreen = true
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
                        // go to LandlordRequestListView
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: 50)
                                .padding([.leading, .trailing], 20)
                                .foregroundColor(.appBlue)

                            Text("View Request")
                                .foregroundColor(.appAliceBlue)
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                        }
                    }
                    .padding(.top,5)
                    
                    Button {
                        // Make isActive toggle
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
                    
                } else {
                    HStack(spacing: 10) {
                        Text("Rent:")
                            .foregroundColor(.appGrayBlue)
                            .fontWeight(.bold)
                            
                        Text("$ \(String(format: "%.2f", property.rent))")
                        
                        Spacer()
                    }
                    .padding([.leading, .trailing], 20)
                    .padding(.top, 0)
                }
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appColumbiaBlue)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $goToEditProfileScreen) {
            LandlordEditPropertyView(viewModel: self.viewModel)
        }
    }
}

#Preview {
    LandlordPropertyDetailView(viewModel: PropertyViewModel())
}
