//
//  SceneDelegate.swift
//  FxiOS
//
//  Created by Salihcan Kahya on 2.10.2023.
//

import UIKit

// TODO: remove
import FirebaseCore
import GoogleSignIn
import FirebaseAuth
import FirebaseGoogleAuthUI
// --

final class SceneDelegate: UIResponder, UIWindowSceneDelegate, GetResolver {

    var window: UIWindow?
    var coordinator: Coordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        guard let coordinator = returnResolver().resolve(LoginCoordinator.self) else { return }
        self.coordinator = coordinator

        let window = UIWindow(windowScene: windowScene)
        let rootView = coordinator.start()
        let navigationController = UINavigationController(rootViewController: rootView)
        
        coordinator.navigationController = navigationController
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.sign()
        })
    }
    
    // TODO: Will be remove from here and create new usecase that triggered from the loginView signInWithGoogle button
    func sign() {
        let topViewController = window!.rootViewController!
        
        if let clientID = FirebaseApp.app()?.options.clientID {
            let config = GIDConfiguration(clientID: clientID)

            GIDSignIn.sharedInstance.signIn(with:config, presenting: topViewController) { result, error in
                guard let user = result?.authentication,
                      let idToken = user.idToken
                else {
                    return
                }

                let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                               accessToken: user.accessToken)
                
                Auth.auth().signIn(with: credential) { result, error in
                    
                }
            }
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

