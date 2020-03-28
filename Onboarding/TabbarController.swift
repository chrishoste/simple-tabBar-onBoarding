//
//  TabbarController.swift
//  Onboarding
//
//  Created by Christophe Hoste on 27.03.20.
//  Copyright © 2020 Christophe Hoste. All rights reserved.
//

import UIKit

class Tabbarcontoller: UITabBarController {
    
    let onBoardingView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            createNavViewController(viewController: ViewController(), title: "Home", imageName: "house.fill"),
            createNavViewController(viewController: ViewController(), title: "About", imageName: "bubble.middle.bottom.fill"),
            createNavViewController(viewController: ViewController(), title: "Trending", imageName: "flame.fill"),
            createNavViewController(viewController: ViewController(), title: "Settings", imageName: "rectangle.3.offgrid.fill")
        ]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startOnBoarding()
    }

    private func createNavViewController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {

        viewController.navigationItem.title = title

        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: imageName)

        return navController
    }
    
    func startOnBoarding() {
        let onBoardingViewController = OnBoardingViewController(forTabbar: tabBar, numberOfItems: viewControllers?.count ?? 0)
        onBoardingViewController.modalPresentationStyle = .overCurrentContext
        
        present(onBoardingViewController, animated: false, completion: nil)
    }
}

extension UITabBar {
    func getFrameForTabAt(index: Int) -> CGRect? {
        var frames = self.subviews.compactMap { return $0 is UIControl ? $0.frame : nil }
        frames.sort { $0.origin.x < $1.origin.x }
        return frames[index]
    }
}
