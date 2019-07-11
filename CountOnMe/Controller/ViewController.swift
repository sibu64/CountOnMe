import UIKit

class ViewController: UIViewController, UITextFieldDelegate  {
    
    let model = Calculator()
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.delegate = self as? UITextViewDelegate
        
    }
    
    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.font = UIFont.systemFont(ofSize: textView.frame.height/4)
        }
    }
    
    //Hide Keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    @IBOutlet var numberButtons: [UIButton]!
    
    // Update UI with expression
    func updateDisplay() {
        textView.text = model.expression
    }
    
    // MARK: - Action
    
    // Perform a number action
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        if let number = numberButtons
            .sorted(by: { $0.tag < $1.tag })
            .enumerated()
            .first(where: { sender.tag == $0.element.tag } )?.offset {
            
            let stringNumber = "\(number)"
        
            guard model.add(stringNumber) else {
                self.presentAlert(title: "Attention", message: "Impossible d'effectuer cette opération")
                return
            }
            updateDisplay()
        }
    }
    
    // Perform an operator action
    @IBAction func performOperator(_ sender: UIButton) {
        guard let `operator` = sender.currentTitle else { return }
        
        guard model.add(`operator`) == true else {
            self.presentAlert(title: "Attention", message: "Impossible d'effectuer cette opération")
            return
        }
        updateDisplay()
    }
    
    // Action for reset operation
    @IBAction func actionReset(_ sender: UIButton) {
        model.clear()
        updateDisplay()
    }
    
   
    // Action for equality
    @IBAction func equal() {
        guard let result = model.calculate() else {
            self.presentAlert(title: "Attention", message: "Impossible d'effectuer cette opération")
            return
        }
        textView.text = "\(result)"
        model.clear()
    }
    
    // Setting up the alerts
    func presentAlert(title: String = "You can not divide by 0!", message: String) {
        let controller = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let button = UIAlertAction(title: "Ok", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            
        })
        controller.addAction(button)
        self.present(controller, animated: true, completion: nil)
    }
}



