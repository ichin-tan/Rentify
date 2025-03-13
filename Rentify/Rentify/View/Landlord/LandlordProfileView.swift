//
//  LandlordProfileView.swift
//  Rentify
//
//  Created by CP on 11/03/25.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var currentUser: User?
    
    func fetchCurrentUser(completion: ((User) -> ())?) {
        if let currentID = FirebaseManager.shared.getCurrentUserUIdFromFirebase() {
            FirebaseManager.shared.fetchUser(for: currentID) { user in
                self.currentUser = user
                completion?(self.currentUser!)
            }
        }
    }
}

struct LandlordProfileView: View {
        
    @StateObject private var viewModel = ProfileViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowAlert: Bool = false
    @State private var isShowLogoutAlert: Bool = false
    @State private var strAlertMessage: String = ""
    @State private var showEditFields: Bool = false
    @State private var strName: String = ""
    @State private var strContact: String = ""
    @State private var strEmail: String = ""

    var body: some View {
        VStack {
            
            HStack {
                Text("Profile")
                    .padding(.bottom, 10)
                    .padding(.leading, 40)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 30))
                
                Button {
                    isShowLogoutAlert = true
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.system(size: 25))
                        .padding(.bottom, 5)
                }
                .padding(.trailing, 15)
            }
            .foregroundColor(.appAliceBlue)
            .background(Color.appBlue)
            .fontWeight(.bold)
                            
            if let user = viewModel.currentUser {
                VStack(spacing: 20) {
                    HStack {
                        Text("Name:")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.appGrayBlue)
                        Spacer()
                        Text(user.name)
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .foregroundColor(.appBlue)
                    }
                    .padding([.leading, .trailing], 20)
                    
                    HStack {
                        Text("Email:")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.appGrayBlue)
                        Spacer()
                        Text(user.email)
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .foregroundColor(.appBlue)
                    }
                    .padding([.leading, .trailing], 20)
                    
                    HStack {
                        Text("Contact:")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.appGrayBlue)
                        Spacer()
                        Text(user.contact)
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .foregroundColor(.appBlue)
                    }
                    .padding([.leading, .trailing], 20)
                    
                    // Edit Profile Button
                    if showEditFields {
                        nameTextField
                        emailTextField
                        contactTextField
                    }

                    editProfileButton
                    
                    
                    
                }
                .padding(.top, 20)

            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.appColumbiaBlue)
                    .overlay {
                        ProgressView()
                    }
            }
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appColumbiaBlue)
        .onAppear {
            viewModel.fetchCurrentUser { user in
                strName = user.name
                strEmail = user.email
                strContact = user.contact
            }
        }
        .alert(isPresented: Binding(
            get: { isShowAlert || isShowLogoutAlert },
            set: { _ in
                isShowAlert = false
                isShowLogoutAlert = false
            }
        )) {
            if isShowLogoutAlert {
                return Alert(
                    title: Text("Rentify"),
                    message: Text("Do you really want to logout?"),
                    primaryButton: .default(Text("Yes")) {
                        FirebaseManager.shared.logout { success in
                            if success {
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                strAlertMessage = "Something went wrong while logout!"
                                isShowAlert = true
                            }
                        }
                    },
                    secondaryButton: .cancel(Text("Cancel")) {
                        print("Cancel button tapped!")
                    }
                )
            } else {
                return Alert(
                    title: Text("Rentify"),
                    message: Text(strAlertMessage),
                    dismissButton: .default(Text("OK")) {
                        print("Alert dismissed!")
                    }
                )
            }
        }
    }
    
    var editProfileButton: some View {
        Button {
            // Code To Edit Profile
            self.editProfile()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 50)
                    .padding([.leading, .trailing], 20)
                    .padding(.top, 10)
                    .foregroundColor(.appBlue)

                Text(showEditFields ? "Edit" : "Edit Profile")
                    .padding(.top, 12)
                    .foregroundColor(.appAliceBlue)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
            }
        }
    }
    
    var nameTextField: some View {
        TextField("Name", text: $strName)
            .frame(height: 25)
            .keyboardType(.default)
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
            .autocorrectionDisabled()
            .autocapitalization(.none)
    }
    
    var emailTextField: some View {
        TextField("Email", text: $strEmail)
            .frame(height: 25)
            .keyboardType(.emailAddress)
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
            .autocorrectionDisabled()
            .autocapitalization(.none)
    }
    
    var contactTextField: some View {
        TextField("Contact", text: $strContact)
            .frame(height: 25)
            .keyboardType(.numberPad)
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
            .autocorrectionDisabled()
            .autocapitalization(.none)
    }
    
    private func editProfile() {
        if(showEditFields == false) {
            showEditFields = true
        } else {
            if(isValidated()) {
                if let previousUser = viewModel.currentUser {
                    
                    if(previousUser.name == strName && previousUser.contact == strContact && previousUser.email == strEmail) {
                        showEditFields = false
                    } else {
                        let user = User(id: previousUser.id, name: strName, email: strEmail, contact: strContact, role: previousUser.role)
                        FirebaseManager.shared.createOrUpdateUser(user: user) { success in
                            if(success) {
                                viewModel.currentUser = user
                                showEditFields = false
                                strAlertMessage = "User Updated!"
                                isShowAlert = true
                            } else {
                                strAlertMessage = "Something went wrong!"
                                isShowAlert = true
                            }
                        }
                    }
                } else {
                    strAlertMessage = "Couldn't get previous user data!"
                    isShowAlert = true
                }
            }
        }
    }
    
    private func isValidated() -> Bool {
        var isValidate = true
        if(strName.isEmpty) {
            isValidate = false
            strAlertMessage = "Name cannot be empty!"
            isShowAlert = true
        } else if(strEmail.isEmpty) {
            isValidate = false
            strAlertMessage = "Email cannot be empty!"
            isShowAlert = true
        } else if(!isValidEmail(strEmail)) {
            isValidate = false
            strAlertMessage = "Email cannot be invalid!"
            isShowAlert = true
        } else if(strContact.isEmpty) {
            isValidate = false
            strAlertMessage = "Contact cannot be empty!"
            isShowAlert = true
        } else if(strContact.count != 10) {
            isValidate = false
            strAlertMessage = "Contact should be of 10 numbers!"
            isShowAlert = true
        }
        return isValidate
    }

}

#Preview {
    LandlordProfileView()
}
