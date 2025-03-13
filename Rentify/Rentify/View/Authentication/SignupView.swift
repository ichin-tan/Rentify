//
//  SignupView.swift
//  Rentify
//
//  Created by CP on 09/03/25.
//

import SwiftUI

struct SignupView: View {
    
    @State private var selectedRole: Role = .Landlord
    @State private var strName: String = ""
    @State private var strContact: String = ""
    @State private var strEmail: String = ""
    @State private var strPassword: String = ""
    @State private var isPasswordVisible: Bool = false
    @FocusState private var isPasswordFocused: Bool
    @State private var isRememberMe: Bool = false
    @State private var isShowAlert: Bool = false
    @State private var strAlertMessage: String = ""
    private let arrRoleSelection: [Role] = [.Landlord, .Tenant]
    @Environment(\.presentationMode) var presentationMode
    @State private var goToLandlordTabView: Bool = false
    @State private var goToTenantTabView: Bool = false

    
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
                
                Text("SIGN UP")
                    .padding(.bottom, 10)
                    .padding(.trailing, 40)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 30))
            }
            .foregroundColor(.appAliceBlue)
            .background(Color.appBlue)
            .fontWeight(.bold)
            
            roleView
            
            VStack(spacing: 15) {
                nameTextField
                emailTextField
                contactTextField
                passwordTextField
            }
            
            rememberMeView
            
            signupButton
                        
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appColumbiaBlue)
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $isShowAlert) {
            Alert(title: Text("Rentify"), message: Text("\(self.strAlertMessage)"),dismissButton: .default(Text("OK"), action: {
                print("Alert dismissed!")
            }))
        }
        .navigationDestination(isPresented: $goToLandlordTabView) {
            LandlordTabView()
        }
        .navigationDestination(isPresented: $goToTenantTabView) {
            LandlordTabView()
        }
    }
    
    var roleView: some View {
        HStack(spacing: 10) {
            Text("Select Role ->")
                .foregroundColor(.appGrayBlue)
                .font(.system(size: 20))
                .fontWeight(.medium)
                        
            Menu {
                Picker("", selection: $selectedRole) {
                    ForEach(self.arrRoleSelection, id: \.self) { roleOption in
                        Text(roleOption.rawValue.capitalized)
                    }
                }
            } label: {
                Text(selectedRole.rawValue.capitalized)
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
            }
        }
        .padding([.leading, .trailing], 20)
        .padding(.top, 10)
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

    
    var passwordTextField: some View {
        Group {
            if isPasswordVisible {
                TextField("Password", text: $strPassword)
                    .focused($isPasswordFocused)
            } else {
                SecureField("Password", text: $strPassword)
                    .focused($isPasswordFocused)
            }
        }
        .frame(height: 25)
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
            .overlay(alignment: .trailing) {
                Button {
                    withAnimation {
                        let wasFocused = isPasswordFocused
                        isPasswordVisible.toggle()
                        if wasFocused {
                            DispatchQueue.main.async {
                                isPasswordFocused = true
                            }
                        }
                    }
                } label: {
                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                        .padding(.trailing, 30)
                        .foregroundColor(.appBlue)
                        .fontWeight(.black)
                }
            }
    }
    
    var rememberMeView: some View {
        HStack(spacing: 10) {
            Text("Remember Me")
                .foregroundColor(.appGrayBlue)
                .fontWeight(.medium)
            
            Button {
                isRememberMe.toggle()
            } label: {
                if isRememberMe {
                    trueCheckbox
                } else {
                    falseCheckBox
                }
            }
            
        }
        .padding([.leading, .trailing], 20)
        .padding(.top, 10)
    }
    
    var falseCheckBox: some View {
        RoundedRectangle(cornerRadius: 4)
            .stroke(.appGrayBlue, lineWidth: 1)
            .frame(width: 20, height: 20)
            .background(.appAliceBlue)
    }
    
    var trueCheckbox: some View {
        
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
    
    var signupButton: some View {
        Button {
            self.signUp()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 50)
                    .padding([.leading, .trailing], 20)
                    .padding(.top, 10)
                    .foregroundColor(.appBlue)

                Text("Sign Up")
                    .padding(.top, 12)
                    .foregroundColor(.appAliceBlue)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
            }
        }
    }
    
    private func signUp() {
        if(isValidated()) {
            FirebaseManager.shared.signupWith(email: strEmail, password: strPassword) { result in
                if(result) {
                    // have to create user
                    
                    if let currentUserId = FirebaseManager.shared.getCurrentUserUIdFromFirebase() {
                        let user = User(id: currentUserId, name: strName, email: strEmail, contact: strContact, role: selectedRole.rawValue)
                        FirebaseManager.shared.createOrUpdateUser(user: user) { result in
                            if(result) {
                                print("User created successfully!")
//                                saveCurrentUserInUD(user: user)
                                self.crearFields()
                                if user.role == Role.Landlord.rawValue {
                                    // Go to Landlord home
                                    self.goToLandlordTabView = true
                                } else {
                                    // Go to Tenant home
                                    self.goToTenantTabView = true
                                }
                            } else {
                                strAlertMessage = "User could not be created!"
                                isShowAlert = true
                            }
                        }
                    } else {
                        print("Authenticated user could not be found!")
                        strAlertMessage = "User could not be created!"
                        isShowAlert = true
                    }
                } else {
                    strAlertMessage = "Something went wrong!"
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
        } else if(strPassword.isEmpty) {
            isValidate = false
            strAlertMessage = "Password cannot be empty!"
            isShowAlert = true
        } else if(strPassword.count < 6) {
            isValidate = false
            strAlertMessage = "Password cannot be less than 6 characters!"
            isShowAlert = true
        }
        return isValidate
    }
    
    private func crearFields() {
        selectedRole = .Landlord
        strName = ""
        strEmail = ""
        strContact = ""
        strPassword = ""
        isPasswordVisible = false
        isPasswordFocused = false
    }
}

#Preview {
    SignupView()
}
