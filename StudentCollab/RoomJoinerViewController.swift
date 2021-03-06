//
//  RoomJoinerViewController.swift
//  StudentCollab
//
//  Created by Mohamed Yassin on 9/16/17.
//  Copyright © 2017 Mohamed Yassin. All rights reserved.
//

import UIKit

class RoomJoinerViewController: UIViewController {
    var ref: FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
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
        
    }
    
    func roomListenerInit() {
        // Firebase listener, this will trigger an update to the room listener
        // This will be using firebase Real time database. Take a look at the
        // Docs
        refHandle = ref.child("rooms").observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            // ...
        })
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
    var host: String = "";
    var status: String = "inactive";
    var students = [Student]();
    init(host:String, status:String){
        self.host = host;
        self.status = status;
    }
}

class Student {
    var name : String = ""
    var answered : Int = 0
    var correct : Int = 0
    init(name:String) {
        self.name = name;
    }
}
