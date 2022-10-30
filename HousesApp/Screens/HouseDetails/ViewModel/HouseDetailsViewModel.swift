//
//  HouseDetailsViewModel.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import Foundation
import Combine

class HouseDetailsViewModel: HouseDetailsViewModelProtocol {
    var gallery: CurrentValueSubject<[PhotoViewData], Never>
    var cancellables: Set<AnyCancellable>
    var details: CurrentValueSubject<HouseViewData, Never>
    var isLoading: PassthroughSubject<Bool, Never>
    var error: CurrentValueSubject<ErrorDataView?, Never>
    var photoService: PhotoServiceProtocol
    var actorService: ActorServiceProtocol
    var rawActors: CurrentValueSubject<[ActorQueryItem], Never>
    var actorsPhotos: CurrentValueSubject<[PhotoViewData], Never>
    var actors: CurrentValueSubject<[ActorViewData]? , Never>
    var actorGroup : DispatchGroup
    
    init(info: HouseViewData, photoService: PhotoServiceProtocol, actorService : ActorServiceProtocol) {
        self.photoService = photoService
        self.actorService = actorService
        self.details = CurrentValueSubject(info)
        self.gallery = CurrentValueSubject([])
        self.actors = CurrentValueSubject(nil)
        self.rawActors = CurrentValueSubject([])
        self.actorsPhotos = CurrentValueSubject([])
        self.isLoading = PassthroughSubject()
        self.error = CurrentValueSubject(nil)
        self.cancellables = []
        self.actorGroup = DispatchGroup()
    }
    
    func loadHousePhotos(){
        photoService.searchPhotos(PhotoParams())
        .sink {[weak self] completed  in
            guard case .failure(let error) = completed else {return}
            self?.error.send(ErrorDataView(with: error))
        } receiveValue: {[weak self] value in
            guard let self = self else {return}
            var items : [PhotoViewData] = []
            value.results.forEach{[weak self] item in
                guard item.urls.small != self?.details.value.photo.mainUrl else {return}
                items.append(PhotoViewData(with: item))
            }
            items.insert(self.details.value.photo, at: 0)
            self.gallery.send(items)
        }.store(in: &cancellables)
    }
    
    func loadActors(){
     isLoading.send(true)
      details.value.actors.forEach {[weak self] value in
            guard let self = self , let id = Int(value) else {return}
            self.actorGroup.enter()
            self.actorService.fetchActorDetails(id)
            .delay(for: 2, scheduler:  RunLoop.main)
            .sink(receiveCompletion: {completed in
                guard case .failure(_) = completed else {return}
                self.actorGroup.leave()
            }, receiveValue: { item in
                self.rawActors.value.append(item)
                self.actorGroup.leave()
            }).store(in: &self.cancellables)
      }
        
        self.actorGroup.enter()
        photoService.searchPhotos(PhotoParams(query: "Person"))
        .sink {[weak self] completed  in
            guard case .failure(let error) = completed else {return}
            self?.error.send(ErrorDataView(with: error))
            self?.actorGroup.leave()
        } receiveValue: {[weak self] value in
            self?.actorsPhotos.send(value.results.map{PhotoViewData(with: $0)})
            self?.actorGroup.leave()
        }.store(in: &cancellables)
        
        actorGroup.notify(queue: .global()) {[weak self] in
            guard let self = self else {return}
            let items = zip(self.rawActors.value, self.actorsPhotos.value).map{ActorViewData(info: $0, photo: $1)}
            self.isLoading.send(false)
            self.actors.send(items)
        }
    }
}
