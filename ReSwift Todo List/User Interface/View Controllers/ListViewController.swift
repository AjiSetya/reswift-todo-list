//
//  ViewController.swift
//  ReSwift Todo List
//
//  Created by Adrian Wisaksana on 3/14/17.
//  Copyright © 2017 Adrian Wisaksana. All rights reserved.
//

import UIKit
import ReSwift

final class ListViewController: UITableViewController {

    // MARK: - Properties
    
    fileprivate let cellIdentifier = "TodoCell"
    
    fileprivate var tasks: [Task] = [] {
        didSet {
            // reload table view whenever the tasks value is updated
            tableView.reloadData()
        }
    }
    
}

extension ListViewController {
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // subscribe for new state
        store.subscribe(self)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // unsubscribe for new state
        store.unsubscribe(self)
        
    }

}

extension ListViewController: StoreSubscriber {
    
    // MARK: - Store subscriber
    
    /// Called whenever the state is updated.
    func newState(state: AppState) {
        
        // sync tasks property with the state's tasks
        tasks = state.tasks
        
    }
    
}

fileprivate extension ListViewController {
    
    // MARK: - Configure
    
    func configure() {
        
        // configure table view
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
    }
    
}

fileprivate extension ListViewController {
    
    // MARK: - Actions
    
    @IBAction func addTask(sender: UIBarButtonItem) {
        
        // let initialCount = store.state.tasks.count
        
        // for the sake of example, just add a hardcoded task
        store.dispatch(
            AddTask(taskName: "💩")
        )
        
        // to test
        // assert(store.state.tasks.count == initialCount + 1)
        
    }
    
}


extension ListViewController {
    
    // MARK: - Table view
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasks.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let task = tasks[indexPath.row]
        
        cell.textLabel?.text = task.title
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // 1. get task at index
        let task = tasks[indexPath.row]
        
        let action = UITableViewRowAction(style: .normal, title: "✅") { _ in
            // 2. dispatch action to remove the task with the id
            store.dispatch(
                RemoveTask(taskId: task.id)
            )
        }
        
        action.backgroundColor = .green
        
        return [action]
        
    }
    
}

