//
//  BaseViewModelProtocol.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//

import Combine

protocol BaseViewModelProtocol  {
    var cancellables: Set<AnyCancellable> {get}
    var isLoading: PassthroughSubject<Bool , Never> {get}
    var error: CurrentValueSubject<ErrorDataView? , Never> {get}
}

class BaseViewModel: BaseViewModelProtocol{
    var cancellables = Set<AnyCancellable>()
    var isLoading = PassthroughSubject<Bool , Never>()
    var error = CurrentValueSubject<ErrorDataView? , Never>(nil)
}
