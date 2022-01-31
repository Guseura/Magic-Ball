import UIKit

class AddCustomAnswerPopup: BaseViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var popupBackgroundView: UIView!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    // Text Fields
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Variables
    
    var onSaveButtonPressed: (()->()) = { }
        
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateIn()
    }
    
    // MARK: - Custom functions
    
    override func localize() {
        titleLabel.localize(with: "popup.label.title")
        saveButton.localize(with: "popup.button.save")
        cancelButton.localize(with: "popup.button.cancel")
    
    }
    
    override func configureUI() {
        popupBackgroundView.roundCorners(radius: 12, corners: .allCorners)
        saveButton.roundCorners(radius: 12, corners: .allCorners)
    }
    
    // Animation
    
    func animateIn() {
        popupBackgroundView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseIn) {
            self.popupBackgroundView.transform = .identity
        }
    }
    
    func animateOut(_ isSavedButtonPressed: Bool = false) {
        self.view.alpha = 1
        UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseIn) {
            self.view.alpha = 0
            self.popupBackgroundView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
        } completion: { completed in
            if isSavedButtonPressed {
                self.onSaveButtonPressed()
            }
            self.view.removeFromSuperview()
        }
    }
        
    // MARK: - @IBActions
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        view.endEditing(true)
        let textFieldText = textField.text ?? ""
        let answer = textFieldText.trimmingCharacters(in: .whitespacesAndNewlines)
        if answer != "" {
            State.shared.appendToUserAnswers(answer: answer)
        }
        animateOut(true)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        view.endEditing(true)
        animateOut()
    }
}

/*
 //           _._
 //        .-'   `
 //      __|__
 //     /     \
 //     |()_()|
 //     \{o o}/
 //      =\o/=
 //       ^ ^
 */
