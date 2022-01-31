import UIKit

class MainViewController: BaseViewController {

    // MARK: - @IBOutlets

    // Labels
    @IBOutlet weak var mainLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var settingsButton: UIButton!
    
    // MARK: - Variables
    
    var answers: [String] = []
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        answers = State.shared.getAllAnswers()
    }
    
    // MARK: - Custom functions
    
    override func localize() {
        mainLabel.localize(with: "main.label.shake")
    }
    
    private func getHardcodedAnswer() {
        DispatchQueue.main.async {
            self.mainLabel.text = self.answers.randomElement()
        }
    }
    
    private func getAnswer() {
        MagicNetwork().getMagic { (result) in
            switch result {
            case .success(let newsResponse):
                DispatchQueue.main.async {
                    self.mainLabel.text = newsResponse.magic.answer
                }
            case .failure(_):
                self.getHardcodedAnswer()
            }
        }
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEvent.EventSubtype.motionShake {
            isConnectedToNetwork() ? self.getAnswer() : self.getHardcodedAnswer()
        }
    }
    
    // MARK: - @IBActions
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        let settingsViewController = SettingsViewController.load(from: Main.settings)
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
}
