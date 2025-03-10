//
//  SignupView.swift
//  Rentify
//
//  Created by CP on 09/03/25.
//

import SwiftUI

struct SignupView: View {
    
    @State private var strRoleSelection: String = "Landlord"
    @State private var strEmail: String = ""
    @State private var strPassword: String = ""
    @State private var isRememberMe: Bool = false
    private let arrRoleSelection: [String] = ["Landlord", "Tenant"]
    @Environment(\.presentationMode) var presentationMode
    
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
                emailTextField
                passwordTextField
            }
            
            rememberMeView
            
            signupButton
                        
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appColumbiaBlue)
        .navigationBarBackButtonHidden(true)
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
            // Code To Signup
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 50)
                    .padding([.leading, .trailing], 20)
                    .padding(.top, 10)
                    .foregroundColor(.appBlue)

                Text("SIGN UP")
                    .padding(.top, 12)
                    .foregroundColor(.appAliceBlue)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
            }
        }
    }
}

#Preview {
    SignupView()
}
