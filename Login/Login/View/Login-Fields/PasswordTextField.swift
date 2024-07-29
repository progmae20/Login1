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
    @State private var isSecured: Bool = true
    
    let validatePassword: (String) -> Bool
    let errorText: String
    let placeholder: String
    
    @FocusState var focusedField: FocusedField?
    

    init(_ title: String, text: Binding<String>) {
        self.placeholder = title
        self.$passwordText = text
    }
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
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
                } else {
                    TextField(placeholder, text: $passwordText)
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
                }
            }.padding(.trailing, 32)
            
            if !isValidPassword {
                HStack {
                    Text(errorText)
                        .foregroundStyle(.red)
                        .padding(.leading)
                    Spacer()
                }
            }
            
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
            }
        }
    }
}

#Preview {
    PasswordTextField(passwordText: .constant(""), isValidPassword: .constant(true), validatePassword: Validator.validatePassword, errorText: "Your password is not valid", placeholder: "Password")
}
