//
//  LoginView.swift
//  Rentify
//
//  Created by CP on 08/03/25.
//

import SwiftUI

struct LoginView: View {
    
    @State private var strRoleSelection: String = "Landlord"
    @State private var strEmail: String = ""
    @State private var strPassword: String = ""
    @State private var isRememberMe: Bool = false
    @State private var isGoToSignup: Bool = false
    @State private var isGoToGuestMap: Bool = false
    private let arrRoleSelection: [String] = ["Landlord", "Tenant", "Guest"]
    
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
                
                roleView
                
                if(strRoleSelection == "Guest") {
                    guestLoginButton
                } else {
                                        
                    VStack(spacing: 15) {
                        emailTextField
                        passwordTextField
                    }
                    
                    rememberMeView
                    
                    loginButton
                    
                    signupView
                }
                
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appColumbiaBlue)
        }
    }
    
    var roleView: some View {
        HStack(spacing: 10) {
            Text("Select Role ->")
                .foregroundColor(.appGrayBlue)
                .font(.system(size: 20))
                .fontWeight(.medium)
                        
            Menu {
                Picker("", selection: $strRoleSelection) {
                    ForEach(self.arrRoleSelection, id: \.self) { roleOption in
                        Text(roleOption)
                    }
                }
            } label: {
                Text(strRoleSelection)
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
    
    var emailTextField: some View {
        TextField("Email", text: $strEmail)
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
            .padding(.top, 5)
            .autocorrectionDisabled()
            .autocapitalization(.none)
    }
    
    var passwordTextField: some View {
        TextField("Password", text: $strPassword)
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
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 50)
                    .padding([.leading, .trailing], 20)
                    .padding(.top, 10)
                    .foregroundColor(.appBlue)

                Text("LOG IN")
                    .padding(.top, 12)
                    .foregroundColor(.appAliceBlue)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
            }
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

                Text("GUEST LOGIN")
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
}

#Preview {
    LoginView()
}
