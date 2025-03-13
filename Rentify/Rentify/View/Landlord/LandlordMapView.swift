//
//  LandlordMapView.swift
//  Rentify
//
//  Created by CP on 11/03/25.
//

import SwiftUI
import MapKit

struct LandlordMapView: View {
    
    @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.01, longitude: -116.16),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    ))
    @State private var strSearch: String = ""
    @State private var showSeeDetailPopup: Bool = false
    @State private var goToPropertyDetail: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @State private var showOnlyMyProperties: Bool = false
    @State private var goToAllOwnProperty: Bool = false
    @ObservedObject var viewModel = PropertyViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Map")
                    .padding(.bottom, 10)
                    .padding(.leading, 40)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 30))
                
                Button {
                    goToAllOwnProperty = true
                } label: {
                    Image(systemName: "list.bullet")
                        .font(.system(size: 25))
                        .padding(.bottom, 5)
                }
                .padding(.trailing, 15)
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
                
//                Button {
//                    
//                } label: {
//                    Image(systemName: "magnifyingglass")
//                        .font(.system(size: 20, weight: .bold))
//                        .frame(width: 40, height: 40)
//                        .background(Color.appBlue.opacity(0.9))
//                        .foregroundColor(.appAliceBlue)
//                        .clipShape(Circle())
//                }
            }
            .padding([.leading, .trailing], 20)
            .padding(.top, 15)
            .padding(.bottom, 0)
            
            ownPropertyCheckBoxView
            
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
                        
                        SeeDetailPopUpView(forRole: .Landlord, annotationTitle: property.address) {
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
            LandlordPropertyDetailView(viewModel: self.viewModel)
        }
        .navigationDestination(isPresented: $goToAllOwnProperty) {
            LandlordPropertyListView(viewModel: self.viewModel)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appColumbiaBlue)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear() {
            self.viewModel.fetchProperties()
        }
    }
    
    var ownPropertyCheckBoxView: some View {
        HStack(spacing: 10) {
            Text("Show my own properties")
                .foregroundColor(.appGrayBlue)
                .fontWeight(.medium)
            
            Button {
                showOnlyMyProperties.toggle()
            } label: {
                if showOnlyMyProperties {
                    trueCheckbox
                } else {
                    falseCheckBox
                }
            }
        }
        .padding([.leading, .trailing], 20)
        .padding(.top, 10)
    }
    
    private var falseCheckBox: some View {
        RoundedRectangle(cornerRadius: 4)
            .stroke(.appGrayBlue, lineWidth: 1)
            .frame(width: 20, height: 20)
            .background(.appAliceBlue)
    }
    
    private var trueCheckbox: some View {
        RoundedRectangle(cornerRadius: 4)
            .stroke(.appGrayBlue, lineWidth: 1)
            .frame(width: 20, height: 20)
            .background(.appAliceBlue)
            .overlay {
                Image(systemName: "checkmark")
                    .foregroundColor(.appGrayBlue)
                    .fontWeight(.bold)
            }
    }
    
    func searchedProperties() -> [Property] {
        var localProperties = self.viewModel.properties
        localProperties = localProperties.filter({ $0.isActivated })
        if (showOnlyMyProperties) {
            let myOnlyProperties = localProperties.filter({ $0.addedByLandlordId == FirebaseManager.shared.getCurrentUserUIdFromFirebase() })
            if (strSearch.isEmpty) {
                return myOnlyProperties
            } else {
                return myOnlyProperties.filter({ $0.address.lowercased().contains(strSearch.lowercased()) })
            }
        } else {
            if (strSearch.isEmpty) {
                return localProperties
            } else {
                return localProperties.filter({ $0.address.lowercased().contains(strSearch.lowercased()) })
            }
        }
    }
}

#Preview {
    LandlordMapView()
}
