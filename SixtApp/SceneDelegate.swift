//
//  SceneDelegate.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 4.07.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)

 
        /*  Comment for reviewer:
                I'd like to use storyboard because it seems easier to implement this demo. I can also able to create all UI by code.
                I need to uncheck "Is Initial View Controller" checkbox to prevent it lauching by itself
         */

        //instantiate api services here
        let api = ApiFactory.service(.sixt)!
        
        //get tabbar
        let tabBarController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(identifier: "TabBarControllerID") as! UITabBarController
        
        //inject api service to the first tab - cars table view screen
        if let nvc = tabBarController.viewControllers?.first as? UINavigationController,
           let vc1 = nvc.viewControllers.first as? ViewController{
            vc1.api = api
            vc1.getCars { cars in
                vc1.cars = cars
                vc1.tableview.reloadData()
            }
        }
        //inject api service to the second tab - map view screen
        if let mapvc = tabBarController.viewControllers?[1] as? MapViewController{
            mapvc.api = api
        }

            
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
            
        //}
        
        
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

