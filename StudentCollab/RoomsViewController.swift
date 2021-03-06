//
//  RoomsViewController.swift
//  StudentCollab
//
//  Created by Mohamed Yassin on 9/16/17.
//  Copyright © 2017 Mohamed Yassin. All rights reserved.
//

import UIKit
import Firebase
import SCLAlertView

class RoomsViewController: UIViewController, UITableViewDataSource{


    var createRoomAlert = SCLAlertView()

    @IBAction func createButtonClick(_ sender: Any) {
        createRoomAlert.showInfo("Create Room", subTitle: "Create your own room!")
    }

    let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!
    )

    var ref: DatabaseReference!
    @IBOutlet weak var roomsTableView: UITableView!
    var roomsDatabaseListener : UInt!
    var rooms = [Room]();


    // Table View Boiler Plate
    // How many sections, since its going to only be one just do one.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Return Int, how many rows in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }

    // Called every time for each row
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.roomsTableView.dequeueReusableCell(withIdentifier: "CustomTableCell") as? RoomsTableViewCell
        let room = self.rooms[indexPath.row]
        
        cell?.labelText.text = room.name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        let destination = UIViewController() // Your destination
        navigationController?.pushViewController(destination, animated: true)
    }





    override func viewDidLoad() {
        ref = Database.database().reference().child("rooms")
        super.viewDidLoad()
        initialize();
        roomsTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func initialize() {
        roomListenerInit();
        createButtonDialogInit();
    }

    func roomListenerInit() {
        // Firebase listener, this will trigger an update to the room listener
        // This will be using firebase Real time database. Take a look at the
        // Docs
        roomsDatabaseListener = ref.observe(DataEventType.value, with: { (snapshot) in
            if !snapshot.exists() { return }
            self.rooms = [Room]();
            let enumerator = snapshot.children
            while let roomSnap = enumerator.nextObject() as? DataSnapshot {
                guard let room = roomSnap.value as? [String: Any] else { continue }
                let status = room["status"] as! String
                if(status == "active" ) {
                    let newRoom : Room = Room(name: room["name"] as! String, host: room["host"] as! String, status: room["status"] as! String);
                    self.rooms.append(newRoom)
                }
            }

                self.roomsTableView.reloadData()
        })
    }
    
    func createButtonDialogInit() {
        // Dialog setup for when the create button is clicked
        // Using SCL Alert View
        createRoomAlert = SCLAlertView(appearance: appearance)
        let nameText = createRoomAlert.addTextField("Room Name")
        let hostText = createRoomAlert.addTextField("Enter your name")


        createRoomAlert.addButton("Create Room") {
            let name : String = nameText.text!
            let host : String = hostText.text!
            if(name == "" || host == ""){
                return
            }
            self.ref?.removeObserver(withHandle: self.roomsDatabaseListener)
            let directory = self.ref.child("room_"+String(arc4random_uniform(100)));
            directory.child("status").setValue("inactive")
            directory.child("host").setValue(self.cleanString(text: host))
            directory.child("name").setValue(self.cleanString(text: name))
            self.roomListenerInit()
            directory.child("status").setValue("active")
            self.createButtonDialogInit()
        }
    }

    func cleanString(text:String) -> String {
        let disallowedChars = CharacterSet.urlPathAllowed.inverted
        return text.components(separatedBy: disallowedChars).joined(separator: "")
    }

}



class Room {
    var name: String = ""
    var host: String = "";
    var status: String = "inactive";
    var students = [Student]();
    init(name:String,host:String, status:String){
        self.name = name
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
