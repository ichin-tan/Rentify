//
//  GuestPropertyDetailView.swift
//  Rentify
//
//  Created by CP on 10/03/25.
//

import SwiftUI

struct GuestPropertyDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: PropertyViewModel
    
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
                
                Text("Properties")
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
                
                if let landlord = viewModel.landlord {
                    VStack {
                        Text("Landlord Details")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .padding(.top, 10)
                        
                        HStack(spacing: 10) {
                            Text("Name:")
                                .foregroundColor(.appGrayBlue)
                                .fontWeight(.bold)
                                
                            Text(landlord.name)
                            
                            Spacer()
                        }
                        .padding([.leading, .trailing], 20)
                        .padding(.top, 10)
                        
                        HStack(spacing: 10) {
                            Text("Email:")
                                .foregroundColor(.appGrayBlue)
                                .fontWeight(.bold)
                                
                            Text(landlord.email)
                            
                            Spacer()
                        }
                        .padding([.leading, .trailing], 20)
                        .padding(.top, 0)

                        HStack(spacing: 10) {
                            Text("Contact:")
                                .foregroundColor(.appGrayBlue)
                                .fontWeight(.bold)
                                
                            Button() {
                                guard let url = URL(string: "telprompt://\(landlord.contact)") else { return }
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            } label: {
                                Text(landlord.contact)
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
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appColumbiaBlue)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear() {
            if let property = self.viewModel.selectedProperty {
                self.viewModel.fetchLandLord(userID: property.addedByLandlordId)
            }
        }
    }
}

#Preview {
    GuestPropertyDetailView(viewModel: PropertyViewModel())
}
