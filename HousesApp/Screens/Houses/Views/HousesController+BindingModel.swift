//
//  HousesController+BindingModel.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//

import Foundation

extension HousesController {
    func bindingHousesToCollectionView(){
        viewModel.houses
        .receive(on: DispatchQueue.main)
        .sink { items in
           self.collectionView.reloadData()
        }.store(in: &cancellables)
    }
    
    func bindingIsLoadingToAnimator(){
        viewModel.isLoading
        .receive(on: DispatchQueue.main)
        .sink {[weak self] status in
            _  = status ? self?.collectionView.showAnimatedGradientSkeleton() : self?.stopSkeletonAnimation()
        }.store(in: &cancellables)
    }
    
    func bindingError(){
        viewModel.error
        .receive(on: DispatchQueue.main)
        .sink {[weak self] error in
            guard let error = error else {return}
            self?.stopSkeletonAnimation()
            self?.collectionView.setMessage(error.message)
            
        }.store(in: &cancellables)
    }
}
