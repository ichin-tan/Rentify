//
//  TenantPropertyDetailView.swift
//  Rentify
//
//  Created by CP on 13/03/25.
//

import SwiftUI

struct TenantPropertyDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: PropertyViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TenantPropertyDetailView(viewModel: PropertyViewModel())
}
