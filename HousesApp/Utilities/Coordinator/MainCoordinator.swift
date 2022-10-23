//
//  MainCoordinator.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//

import UIKit

final class MainCoordinator: Coordinator{
    
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    init(navigation : UINavigationController) {
        childCoordinators = []
        navigationController = navigation
    }
    
    func start() {
        let housesView = HousesController()
        pushViewControllerToStack(with: housesView)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
}

extension MainCoordinator {
    func pushViewControllerToStack(with value : UIViewController , animated : Bool = true){
        navigationController.pushViewController(value, animated: animated)
    }
}

