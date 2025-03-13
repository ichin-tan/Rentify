//
//  LoginView.swift
//  Rentify
//
//  Created by CP on 08/03/25.
//

import SwiftUI

struct LoginView: View {
    
    @State private var strEmail: String = ""
    @State private var strPassword: String = ""
    @State private var isPasswordVisible: Bool = false
    @FocusState private var isPasswordFocused: Bool
    @State private var isRememberMe: Bool = false
    @State private var isGoToSignup: Bool = false
    @State private var isGoToGuestMap: Bool = false
    @State private var isShowAlert: Bool = false
    @State private var strAlertMessage: String = ""
    
    @State private var goToLandlordTabView: Bool = false
    @State private var goToTenantTabView: Bool = false

    
    var body: some View {
        
        NavigationStack {
            VStack {
                Text("LOG IN")
                    .padding(.bottom, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.appBlue)
                    .font(.system(size: 30))
                    .foregroundColor(.appAliceBlue)
                    .fontWeight(.bold)
                                
                VStack(spacing: 15) {
                    emailTextField
                    passwordTextField
                }
                
                rememberMeView
                
                loginButton
                                    
                signupView
                
                guestLoginButton

                
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appColumbiaBlue)
            .alert(isPresented: $isShowAlert) {
                Alert(title: Text("Rentify"), message: Text("\(self.strAlertMessage)"),dismissButton: .default(Text("OK"), action: {
                    print("Alert dismissed!")
                }))
            }
            .onAppear() {
                if(currentUserRememberME) {
                    strEmail = currentUserEmail
                    strPassword = currentUserPassword
                    isPasswordVisible = false
                    isRememberMe = true
                }
            }
        }
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
            .padding(.top, 20)
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
    
    var loginButton: some View {
        Button {
            // Code To Login
            login()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 50)
                    .padding([.leading, .trailing], 20)
                    .padding(.top, 10)
                    .foregroundColor(.appBlue)

                Text("Log In")
                    .padding(.top, 12)
                    .foregroundColor(.appAliceBlue)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
            }
        }
        .navigationDestination(isPresented: $goToLandlordTabView) {
            LandlordTabView()
        }
        .navigationDestination(isPresented: $goToTenantTabView) {
            TenantTabView()
        }
    }
    
    var signupView: some View {
        HStack(spacing: 5) {
            
            Text("Don't have an account?")
                .fontWeight(.medium)
                .foregroundColor(.appGrayBlue)
            
            Button {
                isGoToSignup = true
            } label: {
                Text("SIGN UP")
                    .fontWeight(.medium)
                    .foregroundColor(.appBlue)
            }
            .navigationDestination(isPresented: $isGoToSignup) {
                SignupView()
            }
        }
        .padding(.top, 5)
    }
    
    var guestLoginButton: some View {
        Button {
            isGoToGuestMap = true
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 50)
                    .padding([.leading, .trailing], 20)
                    .padding(.top, 10)
                    .foregroundColor(.appBlue)

                Text("Browse As Guest")
                    .padding(.top, 12)
                    .foregroundColor(.appAliceBlue)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
            }
        }
        .navigationDestination(isPresented: $isGoToGuestMap) {
            GuestMapView()
        }
    }
    
    private func login() {
        if(isValidated()) {
            FirebaseManager.shared.loginWith(email: strEmail, password: strPassword) { result, message in
                if result {
                    if let currentUserId = FirebaseManager.shared.getCurrentUserUIdFromFirebase() {
                        FirebaseManager.shared.fetchUser(for: currentUserId) { user in
                            if let user = user {
                                if(isRememberMe) {
                                    currentUserRememberME = true
                                    currentUserEmail = user.email
                                    currentUserPassword = strPassword
                                } else {
                                    currentUserRememberME = false
                                    currentUserEmail = ""
                                    currentUserPassword = ""
                                    self.crearFields()
                                }
                                if user.role == Role.Landlord.rawValue {
                                    print("Landlord logged in")
                                    self.goToLandlordTabView = true
                                } else {
                                    print("Tenant logged in")
                                    self.goToTenantTabView = true
                                }
                            } else {
                                strAlertMessage = "Something went wrong!"
                                isShowAlert = true
                            }
                        }
                    } else {
                        print("Authenticated user could not be found!")
                        strAlertMessage = "User could not be found!"
                        isShowAlert = true
                    }
                } else {
                    strAlertMessage = message
                    isShowAlert = true
                }
            }
        }
    }
    
    private func isValidated() -> Bool {
        var isValidate = true
        if(strEmail.isEmpty) {
            isValidate = false
            strAlertMessage = "Email cannot be empty!"
            isShowAlert = true
        } else if(!isValidEmail(strEmail)) {
            isValidate = false
            strAlertMessage = "Email cannot be invalid!"
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
        strEmail = ""
        strPassword = ""
        isPasswordVisible = false
        isPasswordFocused = false
    }

}

#Preview {
    LoginView()
}
