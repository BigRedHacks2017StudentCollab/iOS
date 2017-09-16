//
//  RoomsViewController.swift
//  StudentCollab
//
//  Created by Mohamed Yassin on 9/16/17.
//  Copyright © 2017 Mohamed Yassin. All rights reserved.
//

import UIKit

class RoomsViewController:  UIViewController, UITableViewDataSource {
    
    
    var rooms = [Room]();
    
    
    @IBOutlet weak var roomsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func initialize() {
        tableViewInit();
        roomListenerInit();
        createButtonDialogInit();
    }
    
    
    
    
    
    
    func tableViewInit() {
        // Boilerplate for the table view for stuff like amount of items etc.
        // Probaly should create a class because it will get somewhat messy and
        // ugly.
        
        // Register the table view cell class and its reuse id
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        
    }
    
    // How many sections, since its going to only be one just do one.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Return Int, how many rows in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rooms.count
    }
    
    // Called every time for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.roomsTableView.dequeueReusableCell(withIdentifier: "Cell") as? RoomsTableViewCell
        let room = self.rooms[indexPath.row]
        
        cell?.labelText.text = room.name
        return cell!
    }
    
    
    
    
    
    
    func roomListenerInit() {
        // Firebase listener, this will trigger an update to the room listener
        // This will be using firebase Real time database. Take a look at the
        // Docs
    }
    
    func createButtonDialogInit() {
        // Dialog setup for when the create button is clicked
        // Using SCL Alert View
    }
    
    @IBAction func NewRoomButton(_ sender: UIButton) {
        // Event when the plus button is clicked
        // It should call a showing of the createButtonDialog
    }
    
}

class Room {
    var name : String = "";
    var host: String = "";
    var status: String = "inactive";
    var students = [Student]();
}

class Student {
    var name : String = ""
    var answered : Int = 0
    var correct : Int = 0
}
