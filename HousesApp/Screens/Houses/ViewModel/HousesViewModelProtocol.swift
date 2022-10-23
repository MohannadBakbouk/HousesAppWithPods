//
//  HousesViewModelProtocol.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//

import Combine

protocol HousesViewModelProtocol: BaseViewModelProtocol {
    var houses : CurrentValueSubject<[HouseViewData] , Never> {get}
}
