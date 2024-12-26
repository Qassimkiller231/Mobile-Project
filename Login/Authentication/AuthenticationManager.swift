//
//  AuthenticationManager.swift
//  testfinalfinal
//
//  Created by Hamed on 14/12/2024.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

struct AuthDataResultModel {
    let uid: String
    let email: String?
    
    init(user: User) {
        self.uid = "\(user.uid)"
        self.email = user.email
    }
}

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() { }
    
    func creatUser(email: String, password: String) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user:  authDataResult.user)
    }
}

