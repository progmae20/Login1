//
//  PasswordTextField.swift
//  Login
//
//  Created by Anastasia on 23.07.24.
//

import SwiftUI

struct PasswordTextField: View {
    @Binding var passwordText: String
    @Binding var isValidPassword: Bool
    let validatePassword: (String) -> Bool
    let errorText: String
    let placeholder: String
    
    @FocusState var focusedField: FocusedField?
    
    var body: some View {
        VStack {
            SecureField(placeholder, text: $passwordText)
                .focused($focusedField, equals: .password)
                .padding()
                .background(.secondaryBlue)
                .cornerRadius(12)
                .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(!isValidPassword ? .red : focusedField == .password ? .primaryBlue : .white , lineWidth: 3)
                )
                .padding(.horizontal)
                .onChange(of: passwordText) { newValue in
                    isValidPassword = validatePassword(newValue)
                }
            if !isValidPassword {
                HStack {
                    Text(errorText)
                        .foregroundStyle(.red)
                        .padding(.leading)
                    Spacer()
                }
            }
            
        }
    }
}

#Preview {
    PasswordTextField(passwordText: .constant(""), isValidPassword: .constant(true), validatePassword: Validator.validatePassword, errorText: "Your password is not valid", placeholder: "Password")
}
