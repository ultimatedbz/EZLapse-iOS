//
//  InitialNavController.swift
//  EZLapse
//
//  Created by Jeffrey Chen on 11/14/15.
//  Copyright © 2015 Jeffrey Chen. All rights reserved.
//

import UIKit

class InitialNavController: UINavigationController {

    override func viewDidLoad() {
      super.viewDidLoad()
      let homeDirectory : String
      let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
      homeDirectory = paths[0]
      
      var size = 0;
      do{
        size = try NSFileManager().contentsOfDirectoryAtPath(homeDirectory).count
      }catch let error as NSError {
        print(error.localizedDescription)
      }
      print(size)
      
      if( size > 0 ){
        performSegueWithIdentifier("one", sender: self)
      }else{
        performSegueWithIdentifier("two", sender: self)
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
