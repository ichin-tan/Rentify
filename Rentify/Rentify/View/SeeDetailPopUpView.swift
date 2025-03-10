//
//  SeeDetailPopUpView.swift
//  Rentify
//
//  Created by CP on 10/03/25.
//

import SwiftUI

struct SeeDetailPopUpView: View {
    var forRole: Role
    var annotationTitle: String
    var onSeeDetails: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text(annotationTitle)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.appGrayBlue)
                        
            Button(action: {
                onSeeDetails()
            }) {
                Text("See Details")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.appBlue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .padding(.bottom, 5)
        .background(Color.appColumbiaBlue)
        .cornerRadius(15)
        .shadow(radius: 10)
        .padding(25)
    }
}

#Preview {
    SeeDetailPopUpView(forRole: .Guest, annotationTitle: "YUOOP") {
        print("Tapped on preview!")
    }
}
