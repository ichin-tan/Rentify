//
//  GuestMapView.swift
//  Rentify
//
//  Created by CP on 09/03/25.
//

import SwiftUI
import MapKit

struct GuestMapView: View {
    
    @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.01, longitude: -116.16),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    ))
    @State private var strSearch: String = ""
    @State private var showSeeDetailPopup: Bool = false
    @State private var goToPropertyDetail: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel : PropertyViewModel = PropertyViewModel()

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left.square.fill")
                        .font(.system(size: 25))
                        .padding(.bottom, 5)
                }
                .padding(.leading, 15)
                
                Text("Map")
                    .padding(.bottom, 10)
                    .padding(.trailing, 40)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 30))
            }
            .foregroundColor(.appAliceBlue)
            .background(Color.appBlue)
            .fontWeight(.bold)

            HStack {
                TextField("Search", text: $strSearch)
                    .font(.system(size: 20))
                    .foregroundColor(.appGrayBlue)
                    .padding(10)
                    .background(.appAliceBlue)
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.appGrayBlue, lineWidth: 1)
                    }
                    .onChange(of: strSearch) { _ , newValue in
                        print(newValue)
                    }
                
            }
            .padding([.leading, .trailing], 20)
            .padding(.top, 15)
            .padding(.bottom, 0)
                        
            ZStack(alignment: .bottomTrailing) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.appGrayBlue)
                    
                    Map(position: $cameraPosition) {
                        
                        ForEach(self.searchedProperties()) { property in
                            Annotation("", coordinate: CLLocationCoordinate2D(latitude: property.latitude, longitude: property.longitude)){
                                Button(action: {
                                    self.viewModel.selectedProperty = property
                                    showSeeDetailPopup = true
                                }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.appAliceBlue)
                                        Text("📍")
                                            .padding(5)
                                    }
                                }
                            }
                        }
                    }
                    .cornerRadius(10)
                    .padding(1)
                    .mapStyle(.hybrid(elevation: .realistic, pointsOfInterest: .all))
                    
                    if showSeeDetailPopup, let property = self.viewModel.selectedProperty {
                        Color.black.opacity(0.7)
                            .cornerRadius(10)
                            .onTapGesture {
                                showSeeDetailPopup = false
                            }
                        
                        SeeDetailPopUpView(forRole: .Tenant, annotationTitle: property.address) {
                            showSeeDetailPopup = false
                            goToPropertyDetail = true
                        }
                    }
                }
            }
            .padding([.leading, .trailing], 20)
            .padding(.top, 15)
            .padding(.bottom, 10)
            Spacer()
        }
        .navigationDestination(isPresented: $goToPropertyDetail) {
            GuestPropertyDetailView(viewModel: self.viewModel)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appColumbiaBlue)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear() {
            self.viewModel.fetchProperties()
        }
    }
    
    func searchedProperties() -> [Property] {
        var localProperties = self.viewModel.properties
        localProperties = localProperties.filter({ $0.isActivated })
        localProperties = localProperties.filter({ $0.rentedUserId == "" })
        if (strSearch.isEmpty) {
            return localProperties
        } else {
            return localProperties.filter({ $0.address.lowercased().contains(strSearch.lowercased()) })
        }
    }
}

#Preview {
    GuestMapView()
}
