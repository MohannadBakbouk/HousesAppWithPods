//
//  Coordinator.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//

import UIKit

protocol Coordinator {
    var childCoordinators : [Coordinator] {get set}
    var navigationController : UINavigationController {get set}
    func start()
    func back()
}

