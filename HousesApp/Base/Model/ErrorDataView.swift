//
//  ErrorDataView.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import Foundation

struct ErrorDataView{
    var title : String
    var message : String
    var icon : String
}

extension ErrorDataView {
    init(message : String){
        self.init(title : "Error" , message : message , icon : Images.exclamationmark)
    }
    
    init (with error : APIError){
        self.init(title : "Error" , message : error.message , icon : Images.exclamationmark)
    }
}
