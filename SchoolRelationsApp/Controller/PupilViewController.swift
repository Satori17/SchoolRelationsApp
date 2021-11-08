//
//  ViewController.swift
//  SchoolRelationsApp
//
//  Created by Saba Khitaridze on 05.11.21.
//

import UIKit

class PupilViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var pupilTableView: UITableView!
    
    //Vars
    var pupils: [Pupil]?
    //Managed object context reference
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPupil()
    }
    
    //MARK: - Custom Functions
    //Fetch pupils
    func fetchPupil() {
        do {
            let request = Pupil.fetchRequest()
            pupils = try context.fetch(request)
            DispatchQueue.main.async {
                self.pupilTableView.reloadData()
            }
        } catch {
            print("Pupil data could not fetched, \(error.localizedDescription)")
        }
    }
    
    //created custom textfields for saving/editing
    func addTextFields(alert: UIAlertController) {
        alert.addTextField { action in
            action.placeholder = "Name"
            action.autocapitalizationType = UITextAutocapitalizationType.words
        }
        alert.addTextField { action in
            action.placeholder = "Surname"
            action.autocapitalizationType = UITextAutocapitalizationType.words
        }
        alert.addTextField { action in
            action.placeholder = "Gender"
            action.autocapitalizationType = UITextAutocapitalizationType.words
        }
        alert.addTextField { action in
            action.placeholder = "Class"
            action.keyboardType = .numberPad
        }
    }

    //MARK: - IBActions
    @IBAction func addPupilBtnPressed(_ sender: UIBarButtonItem) {
        //Add pupil
        let alert = UIAlertController(title: "Add pupil", message: nil, preferredStyle: .alert)
       addTextFields(alert: alert)
        //Save new pupil
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { action in
            let newPupil = Pupil(context: self.context)
            let pupilNameTextField = alert.textFields![0]
            let pupilSurnameTextField = alert.textFields![1]
            let pupilGenderTextField = alert.textFields![2]
            let pupilClassTextField = alert.textFields![3]
           
            if let pupilName = pupilNameTextField.text {
                newPupil.name = pupilName != "" ? pupilName : "Unknown"
            }
            if let pupilSurname = pupilSurnameTextField.text {
                newPupil.surname = pupilSurname != "" ? pupilSurname : "Unknown"
            }
            if let pupilGender = pupilGenderTextField.text {
                newPupil.gender = pupilGender != "" ? pupilGender : "Unspecified"
            }
            if let pupilClass = pupilClassTextField.text {
                newPupil.classYear = pupilClass != "" ? pupilClass : "Unspecified"
            }
            
            do {
                try self.context.save()
            } catch {
                print("New pupil could not saved, \(error.localizedDescription)")
            }
            
            //re-fetching data
            self.fetchPupil()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
  
    @IBAction func teacherButtonPressed(_ sender: UIButton) {
        
    }
    
}

//MARK: - TableView

extension PupilViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let pupils = pupils {
            return pupils.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pupilCell", for: indexPath) as! pupilCell
        let currentPupil = pupils![indexPath.row]
        cell.pupilNameLabel.text = currentPupil.name
        cell.pupilSurnameLabel.text = currentPupil.surname
        cell.pupilGenderLabel.text = currentPupil.gender
        cell.pupilClassLabel.text = currentPupil.classYear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
    
    //editing pupils
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentPupil = self.pupils![indexPath.row]
        let alert = UIAlertController(title: "Edit Pupil", message: nil, preferredStyle: .alert)
       addTextFields(alert: alert)
        
        let pupilNameTextField = alert.textFields![0]
        let pupilSurnameTextField = alert.textFields![1]
        let pupilGenderTextField = alert.textFields![2]
        let pupilClassTextField = alert.textFields![3]
        
        pupilNameTextField.text = currentPupil.name
        pupilSurnameTextField.text = currentPupil.surname
        pupilGenderTextField.text = currentPupil.gender
        pupilClassTextField.text = currentPupil.classYear
        
        //save edited pupil
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { action in
    
            let pupilNameTextField = alert.textFields![0]
            let pupilSurnameTextField = alert.textFields![1]
            let pupilGenderTextField = alert.textFields![2]
            let pupilClassTextField = alert.textFields![3]
           
            if let pupilName = pupilNameTextField.text {
                currentPupil.name = pupilName != "" ? pupilName : "Unknown"
            }
            if let pupilSurname = pupilSurnameTextField.text {
                currentPupil.surname = pupilSurname != "" ? pupilSurname : "Unknown"
            }
            if let pupilGender = pupilGenderTextField.text {
                currentPupil.gender = pupilGender != "" ? pupilGender : "Unspecified"
            }
            if let pupilClass = pupilClassTextField.text {
                currentPupil.classYear = pupilClass != "" ? pupilClass : "Unspecified"
            }
            
            do {
                try self.context.save()
            } catch {
                print("edition of pupil could not saved, \(error.localizedDescription)")
            }
            
            //re-fetching data
            self.fetchPupil()
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
    self.present(alert, animated: true, completion: nil)
    }

    //removing pupils
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let currentPupil = pupils![indexPath.row]
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            context.delete(currentPupil)
            self.pupils?.remove(at: indexPath.row)
            self.pupilTableView.deleteRows(at: [indexPath], with: .automatic)
            do {
                try self.context.save()
            } catch {
                print("Could not remove \(error.localizedDescription)")
            }
        }
    }
}

