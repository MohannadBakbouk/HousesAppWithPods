//
//  BaseViewController.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import UIKit
import Combine

class BaseViewController<VM : BaseViewModelProtocol> : UIViewController {
    var cancellables = Set<AnyCancellable>()
    weak var coordinator: MainCoordinator?
    var viewModel: VM!
    
    init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
