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
        let splash = SplashController()
        splash.coordinator = self
        pushViewControllerToStack(with: splash)
    }
    
    func showHouses() {
        let housesView = HousesController(viewModel: HousesViewModel(houseService: HouseService(), photoService: PhotoService()))
        housesView.coordinator = self
        pushViewControllerToStack(with: housesView , isRoot: true)
    }
    
    func showHouseDetails(with value : HouseViewData){
        let housesDetailsView = HouseDetailsController(viewModel: HouseDetailsViewModel(info: value, photoService: PhotoService(), actorService: ActorService()))
        housesDetailsView.coordinator = self
        pushViewControllerToStack(with: housesDetailsView)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
}

extension MainCoordinator {
    func pushViewControllerToStack(with value : UIViewController , animated : Bool = true ,  isRoot: Bool = false){
        _ = isRoot ? navigationController.setViewControllers([], animated: false) : ()
        navigationController.pushViewController(value, animated: animated)
    }
}

