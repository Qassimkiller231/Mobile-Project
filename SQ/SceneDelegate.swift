//
//  SceneDelegate.swift
//  testfinalfinal
//
//  Created by Guest User on 08/12/2024.
//

import UIKit
import Firebase
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Initialize the UIWindow
        window = UIWindow(windowScene: windowScene)

        // Storyboards
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let jobSeekerStoryboard = UIStoryboard(name: "JobSeekerLoginPage", bundle: nil)
        let employerStoryboard = UIStoryboard(name: "employerHomePage", bundle: nil)
        let adminStoryboard = UIStoryboard(name: "adminHomePage", bundle: nil)

        // Set a temporary loading screen as the initial view controller
        let loadingViewController = loginStoryboard.instantiateViewController(withIdentifier: "WelcomeViewController")
        window?.rootViewController = loadingViewController
        window?.makeKeyAndVisible()

        // Check if a user is logged in
        if let currentUser = Auth.auth().currentUser {
            // Fetch user type from Firestore
            let db = Firestore.firestore()
            let userRef = db.collection("Users").document(currentUser.uid)

            userRef.getDocument { [weak self] document, error in
                guard let self = self else { return }

                // Default to WelcomeViewController in case of an error
                var initialViewController: UIViewController = loadingViewController

                if let document = document, document.exists,
                   let userType = document.data()?["userType"] as? String {
                    // Navigate based on userType
                    switch userType {
                    case "admin":
                        print("Loaded admin")
                        initialViewController = adminStoryboard.instantiateViewController(withIdentifier: "AdminHomePageViewController")
                    case "jobSeeker":
                        print("Loaded jobSeeker")
                        initialViewController = jobSeekerStoryboard.instantiateViewController(withIdentifier: "JobSeekerHomepageViewController")
                    case "employer":
                        print("Loaded employer")
                        initialViewController = employerStoryboard.instantiateViewController(withIdentifier: "employerHomePage")
                    default:
                        print("Unknown userType, defaulting to WelcomeViewController")
                        initialViewController = loginStoryboard.instantiateViewController(withIdentifier: "WelcomeViewController")
                    }
                } else {
                    print("No document or userType found, defaulting to WelcomeViewController")
                    initialViewController = loginStoryboard.instantiateViewController(withIdentifier: "WelcomeViewController")
                }

                // Update the rootViewController on the main thread
                DispatchQueue.main.async {
                    self.window?.rootViewController = initialViewController
                    self.window?.makeKeyAndVisible()
                }
            }
        } else {
            // No user is logged in, show the Login screen
            let initialViewController = loginStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
            window?.rootViewController = initialViewController
            window?.makeKeyAndVisible()
        }
    }



    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

