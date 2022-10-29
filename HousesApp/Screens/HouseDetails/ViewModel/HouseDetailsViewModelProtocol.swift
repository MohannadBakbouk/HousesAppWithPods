//
//  HouseDetailsProtocol.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//

import Combine

protocol HouseDetailsViewModelProtocol: BaseViewModelProtocol {
    var details: CurrentValueSubject<HouseViewData, Never> {get}
    var gallery: CurrentValueSubject<[PhotoViewData], Never> {get}
    var actors: CurrentValueSubject<[ActorViewData]? , Never> {get}
    var rawActors: CurrentValueSubject<[ActorQueryItem], Never> {get}
    var actorsPhotos: CurrentValueSubject<[PhotoViewData], Never> {get}
    func loadHousePhotos()
    func loadActors()
}
