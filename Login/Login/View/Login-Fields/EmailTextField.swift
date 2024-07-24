//
//  EmailTextField.swift
//  Login
//
//  Created by Anastasia on 23.07.24.
//

import SwiftUI

struct EmailTextField: View {
    @Binding var emailText: String
    @Binding var isValidEmail: Bool
    
    @FocusState var focusedField: FocusedField?
    
    var body: some View {
        VStack {
            TextField("Email", text: $emailText)
                .focused($focusedField, equals: .email)
                .padding()
                .background(.secondaryBlue)
                .cornerRadius(12)
                .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(!isValidEmail ? .red : focusedField == .email ? .primaryBlue : .white , lineWidth: 3)
                )
                .padding(.horizontal)
                .onChange(of: emailText) { newValue in
                    isValidEmail = Validator.validateEmail(newValue)
                }
                .padding(.bottom, isValidEmail ? 16 : 0)
                
            if !isValidEmail {
                HStack {
                    Text("Your email is not valid!")
                        .foregroundStyle(.red)
                        .padding(.leading)
                    Spacer()
                }
                .padding(.bottom)
            }
            
        }
    }
}

#Preview {
    EmailTextField(emailText: .constant(""), isValidEmail: .constant(true))
}
