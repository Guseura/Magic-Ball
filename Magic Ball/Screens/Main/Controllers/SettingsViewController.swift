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
    
    var answers = ["It`s ok", "Lol", "Nice", "Good job"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(tableView, with: Cell.customAnswer)
    }
    
    // MARK: - Custom functions
    
    override func localize() {
        titleLabel.localize(with: "settings.label.title")
    }
    
    // MARK: - @IBActions
    
    @IBAction func addAnswerButtonPressed(_ sender: Any) {
        let addCustomAnswerPopup = AddCustomAnswerPopup.load(from: Popup.addCustomAnswerPopup)
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
    
}
