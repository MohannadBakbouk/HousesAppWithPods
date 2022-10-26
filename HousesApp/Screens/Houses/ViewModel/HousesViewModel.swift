//
//  HousesViewModel.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import Combine
import Foundation

final class HousesViewModel : HousesViewModelProtocol{
    var houses: CurrentValueSubject<[HouseViewData], Never>
    var cancellables: Set<AnyCancellable>
    var isLoading: PassthroughSubject<Bool, Never>
    var error: CurrentValueSubject<ErrorDataView?, Never>
    var houseService: HouseServiceProtocol
    var photoService: PhotoServiceProtocol
    var photoParams : PhotoParams
    init(houseService: HouseServiceProtocol , photoService: PhotoServiceProtocol) {
        self.houses = CurrentValueSubject([])
        self.isLoading = PassthroughSubject()
        self.error = CurrentValueSubject(nil)
        self.cancellables = []
        self.houseService = houseService
        self.photoService = photoService
        self.photoParams = PhotoParams()
    }
    
    func loadHouses(){
        isLoading.send(true)
        houseService.fetchHouses()
        .combineLatest(photoService.searchPhotos(photoParams))
        .delay(for: 5, scheduler: RunLoop.main)
        .sink {[weak self] completed in
            guard case .failure(let error) = completed else {return}
            self?.isLoading.send(false)
            self?.error.send(ErrorDataView(with: error))
        } receiveValue: {[weak self] (houses , photos) in
            var items = zip(houses, photos.results).map{HouseViewData(info: $0, photo: $1)}
            self?.isLoading.send(false)
            items.sort{$0.actors.count > $1.actors.count}
            self?.houses.send(items)
        }.store(in: &cancellables)
    }
}
