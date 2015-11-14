//
//  LapsesModel.swift
//  EZLapse
//
//  Created by Jeffrey Chen on 11/14/15.
//  Copyright (c) 2015 Jeffrey Chen. All rights reserved.
//

import Foundation

class Lapse {
  let mTitle:String
  var mPhotos:[Photo]
  
  init(title:String){
    mPhotos = []
    mTitle = title
  }
}