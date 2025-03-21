//
//  LandlordPropertyRequestListView.swift
//  Rentify
//
//  Created by CP on 13/03/25.
//

import SwiftUI

struct LandlordPropertyRequestListView: View {
    @ObservedObject var viewModel: PropertyViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var arrRequestedTenants: [User] = []
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
                
                Text("Requested Tenants")
                    .padding(.bottom, 10)
                    .padding(.trailing, 40)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 30))
            }
            .foregroundColor(.appAliceBlue)
            .background(Color.appBlue)
            .fontWeight(.bold)
            
            if(self.arrRequestedTenants.isEmpty) {
                Spacer()
                Text("No one has requested for this property yet!")
                    .foregroundColor(.appGrayBlue)
                    .font(.title3)
                    .padding()
                Spacer()
            } else {
                List {
                    ForEach(self.arrRequestedTenants) { user in
                        HStack(spacing: 15) {

                            VStack(alignment: .leading, spacing: 10) {
                                Text("Name: \(user.name)")
                                Text("Email: \(user.email)")
                                HStack(spacing: 10) {
                                    Text("Contact:")
                                        .foregroundColor(.appGrayBlue)
                                        
                                    Text(user.contact)
                                        .foregroundColor(.appBlue)
                                        .fontWeight(.bold)
                                        .onTapGesture {
                                            guard let url = URL(string: "telprompt://\(user.contact)") else { return }
                                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                        }

                                    Spacer()
                                }
                            }
                            
                            Spacer()

                            Text("Accept")
                                .font(.system(size: 15))
                                .fontWeight(.medium)
                                .foregroundColor(.appGrayBlue)
                                .padding(10)
                                .background(.appAliceBlue)
                                .cornerRadius(10)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.appGrayBlue, lineWidth: 1)
                                }
                                .onTapGesture {
                                    self.viewModel.rentSelectedPropertyToUser(userId: user.id) { success in
                                        if(success) {
                                            strAlertMessage = "Rented to \(user.name)"
                                            isShowAlert = true
                                        } else {
                                            strAlertMessage = "Something went wrong"
                                            isShowAlert = true
                                        }
                                    }
                                }
                            
                        }
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity)
                        .padding(.leading, -5)
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .listRowBackground(listRow)
                        .onTapGesture {
                            print(user.name)
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
            self.viewModel.getTenantsWhoRequestedForCurrentProperty { users in
                self.arrRequestedTenants = users
            }
        }
        .alert(isPresented: $isShowAlert) {
            Alert(title: Text("Rentify"), message: Text("\(self.strAlertMessage)"),dismissButton: .default(Text("OK"), action: {
                if(strAlertMessage.hasPrefix("Rented to")) {
                    presentationMode.wrappedValue.dismiss()
                }
                print("Alert dismissed!")
            }))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appColumbiaBlue)
        .navigationBarBackButtonHidden(true)
    }
    
    var listRow: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.appAliceBlue)
    }
}

#Preview {
    LandlordPropertyRequestListView(viewModel: PropertyViewModel())
}
