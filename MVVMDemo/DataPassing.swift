//
//  DataPassing.swift
//  MVVMDemo
//
//  Created by Steven Hsieh on 2020/6/10.
//  Copyright © 2020 Steven Hsieh. All rights reserved.
//

import Foundation


class DataPassing {
    
    static let shared = DataPassing()
    private var index: Int = 0
    private var model: [PhotoModel]!
    
    private init(){
        
    }
    
    func setupForDatail(i: Int, model: [PhotoModel]) {
        self.index = i
        self.model = model
    }
    
    func getDataForDetail() -> PhotoModel {
        return model[index]
    }
    
}
