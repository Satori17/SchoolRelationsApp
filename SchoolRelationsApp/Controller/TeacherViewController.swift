//
//  TeacherViewController.swift
//  SchoolRelationsApp
//
//  Created by Saba Khitaridze on 05.11.21.
//

import UIKit

class TeacherViewController: UIViewController {

    //MARK: - IBOutlets
    //textFields
    @IBOutlet weak var teacherNameTextField: UITextField!
    @IBOutlet weak var teacherSurnameTextField: UITextField!
    @IBOutlet weak var teacherGenderTextField: UITextField!
    @IBOutlet weak var teacherSubjectTextField: UITextField!
    //tableViews
    @IBOutlet weak var pupilsTableView: UITableView!
    @IBOutlet weak var teacherTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - IBAction
    @IBAction func addTeacherBtnPressed(_ sender: UIButton) {
        
    }
    
    
}
