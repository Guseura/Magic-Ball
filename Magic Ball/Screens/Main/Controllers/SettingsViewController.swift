import UIKit

class SettingsViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var backButton: UIButton!
    
    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Awake functions
    
    var answers: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answers = State.shared.getUserAnswers()
        configure(tableView, with: Cell.customAnswer)
    }
    
    // MARK: - Custom functions
    
    override func localize() {
        titleLabel.localize(with: "settings.label.title")
    }
    
    private func presentDeleteAlert(at index: Int) {
        let alert = UIAlertController(title: localized("settings.alert.title"), message: localized("settings.alert.message"), preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: localized("settings.alert.action.delete"), style: .destructive) { _ in
            DispatchQueue.main.async {
                self.answers.remove(at: index)
                userDefaults.setValue(self.answers, forKey: UDKeys.userAnswers)
                self.tableView.reloadData()
                return
            }
        }
        let cancelAction = UIAlertAction(title: localized("settings.alert.action.cancel"), style: .cancel) { _ in
            return
        }
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - @IBActions
    
    @IBAction func addAnswerButtonPressed(_ sender: Any) {
        let addCustomAnswerPopup = AddCustomAnswerPopup.load(from: Popup.addCustomAnswerPopup)
        addCustomAnswerPopup.onSaveButtonPressed = {
            DispatchQueue.main.async {
                self.answers = State.shared.getUserAnswers()
                self.tableView.reloadData()
            }
        }
        showPopup(addCustomAnswerPopup)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.customAnswer.id, for: indexPath) as! CustomAnswerTableViewCell
        cell.answerLabel.text = answers[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentDeleteAlert(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: nil) { action, view, complete in
            self.presentDeleteAlert(at: indexPath.row)
            complete(true)
        }
        
        deleteAction.image = .MBDelete
        deleteAction.backgroundColor = .white
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    
}
