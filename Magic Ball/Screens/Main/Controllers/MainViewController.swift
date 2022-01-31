import UIKit

class MainViewController: BaseViewController {

    // MARK: - @IBOutlets

    // Labels
    @IBOutlet weak var mainLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var settingsButton: UIButton!
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Custom functions
    
    override func localize() {
        mainLabel.localize(with: "main.label.shake")
    }
    
    // MARK: - @IBActions
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        let settingsViewController = SettingsViewController.load(from: Main.settings)
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
}
