//
//  ViewController.swift
//  NotesApp
//
//  Created by Alexander Altman on 13.03.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    var searchedNotes = [Note]()
    static var notes = [Note]()
    
    var searchController = UISearchController(searchResultsController: nil)
    
    var tableView: UITableView?
    
    // Lable for no notes exsists
    let label: UILabel = {
        let label = UILabel()
        label.text = "No notes yet"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .systemGray
        label.backgroundColor = Theme.appcolor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Add new note button
    let button = AddButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        setConstraints()
        view.backgroundColor = Theme.appcolor
        
        
        // setting up search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for note"
        definesPresentationContext = true
        
        setupNavigationController()
        setupTableView()
        setupButton()
        fetchNotesFromStorage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeCellIfEmpty()
    }
    
    @objc private func didTapButton() {
        
        let newNote = CoreDataManager.shared.createNote()
        MainViewController.notes.insert(newNote, at: 0)
        
        tableView!.beginUpdates()
        tableView!.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        tableView!.endUpdates()
        
        let noteVC = NoteViewController()
        noteVC.noteCell = nil
        noteVC.set(noteId: newNote.id)
        noteVC.set(noteCell: (tableView?.cellForRow(at: IndexPath(row: 0, section: 0) ) as! NoteCell))
        
        navigationController?.pushViewController(noteVC, animated: true)
    }
    
    private func setupButton() {
        view.addSubview(button)
        button.setButtonConstraints(view: view)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private func setupNavigationController() {
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = Theme.appcolor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        search(text: text)
    }
    
    func search(text: String) {
        searchNotesFromStorage(text)
    }
}

extension MainViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 30),
            label.widthAnchor.constraint(equalToConstant: 120),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
