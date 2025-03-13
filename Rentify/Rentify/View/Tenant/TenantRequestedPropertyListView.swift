//
//  TenantRequestedPropertyListView.swift
//  Rentify
//
//  Created by CP on 13/03/25.
//

import SwiftUI

struct TenantRequestedPropertyListView: View {
    
    @ObservedObject var viewModel: PropertyViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var goToPropertyDetail: Bool = false
    
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
                
                Text("Requests")
                    .padding(.bottom, 10)
                    .padding(.trailing, 40)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 30))
            }
            .foregroundColor(.appAliceBlue)
            .background(Color.appBlue)
            .fontWeight(.bold)
            if viewModel.getRequestedPropertiesForCurrentUserTenant().isEmpty {
                Spacer()
                Text("You havent requested for any properties yet!")
                    .foregroundColor(.appGrayBlue)
                    .font(.title3)
                    .padding()
                Spacer()
            } else {
                List {
                    ForEach(self.viewModel.getRequestedPropertiesForCurrentUserTenant()) { property in
                        HStack(spacing: 15) {
                            AsyncImage(url: URL(string: property.imgUrl)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.appGrayBlue, lineWidth: 1.5)
                                    }
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.appAliceBlue)
                                    .frame(width: 100, height: 100)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.appGrayBlue, lineWidth: 1)
                                    }
                                    .overlay {
                                        ProgressView()
                                    }
                            }

                            VStack(alignment: .leading, spacing: 10) {
                                Text("Address: \(property.address)")
                                Text("Rent: $\(String(format: "%.2f", property.rent))")
                            }
                            
                            Spacer()

                            Image(systemName: "arrow.right")
                            
                        }
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity)
                        .padding(.leading, -5)
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .listRowBackground(listRow)
                        .onTapGesture {
                            print(property)
                            self.viewModel.selectedProperty = property
                            goToPropertyDetail = true
                        }
                    }
                }
                .listRowSpacing(15)
                .listStyle(.plain)
                .padding([.leading, .trailing], 20)
                .padding(.top, 10)
            }
        }
        .onAppear() {
            self.viewModel.fetchProperties()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appColumbiaBlue)
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $goToPropertyDetail) {
            TenantPropertyDetailView(viewModel: self.viewModel)
        }
    }
    
    var listRow: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.appAliceBlue)
    }
}

#Preview {
    TenantRequestedPropertyListView(viewModel: PropertyViewModel())
}
