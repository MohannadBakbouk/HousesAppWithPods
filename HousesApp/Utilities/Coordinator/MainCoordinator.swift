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
        let housesView = HousesController(viewModel: HousesViewModel(houseService: HouseService(), photoService: PhotoService()))
        housesView.coordinator = self
        pushViewControllerToStack(with: housesView)
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
    func pushViewControllerToStack(with value : UIViewController , animated : Bool = true){
        navigationController.pushViewController(value, animated: animated)
    }
}

