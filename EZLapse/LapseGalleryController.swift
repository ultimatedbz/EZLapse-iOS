//
//  ViewController.swift
//  EZLapse
//
//  Created by Jeffrey Chen on 7/12/15.
//  Copyright (c) 2015 Jeffrey Chen. All rights reserved.
//

import UIKit

class LapseGalleryController: UITableViewController {
  
  let homeDirectory : String
  var size = 0;
  
  
  required init?(coder aDecoder: NSCoder) {

    let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
    homeDirectory = paths[0]
    super.init(coder: aDecoder)
  
  }
  
  override func viewWillAppear(animated: Bool) {
    
    do{
      size = try NSFileManager().contentsOfDirectoryAtPath(homeDirectory).count
    }catch let error as NSError {
      print(error.localizedDescription)
    }
    

    
    
  }
  
  override func numberOfSectionsInTableView(sender: UITableView)-> Int{
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return size
  }
  
  func configureTableView() {
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 160.0
  }
  
  override func tableView(sender: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    let data = indexPath.row
    let dequeued : AnyObject = sender.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
    let cell = dequeued as! GalleryTableViewCell
   
      var s = ""
    do{
      s = try NSFileManager().contentsOfDirectoryAtPath(homeDirectory)[data]
      cell.galleryLabel.text = s
    }catch let error as NSError {
      print(error.localizedDescription)
    }
    
    var albumSize = 0
    do{
      albumSize = try NSFileManager().contentsOfDirectoryAtPath(homeDirectory+"/"+s).count
    }catch let error as NSError {
      print(error.localizedDescription)
    }
    
    
    print(albumSize)
    print((contentsOfFile: homeDirectory + "/" + s+"/\(albumSize-1).jpg"))
    let image = UIImage(contentsOfFile: homeDirectory + "/" + s+"/\(albumSize-1).jpg")
    cell.galleryImage.image = image
    return cell
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

