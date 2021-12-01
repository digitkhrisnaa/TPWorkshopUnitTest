
# An Essential Guide to Unit Test in iOS Application
If you're working as a programmer, Unit Test may sounds familiar to you or even you have working with it.
As iOS developer sometimes we think "What's benefit of using Unit Test? our job only to serving good UI tho", if you think or ask the same question, raise your hand ✋🏼

If you raise your hand or you want learn more about Unit Test, this guide is for you! The guide will include 4 sessions from very beginning to the common usage Unit Test in iOS development world.
Don't forget to clone the repository first before you jump to the section.

## Session 1 - Basic Unit Test
| Problem |
|---------|
|We need an application to detect the odd or even number and format the input number to readable format. We need to start it in `FirstBasicViewController.swift` and achieve the goal|

### Challenge Time
Please stop, before we continue the session, we have a challenge for you:
- Create a function that return boolean true if the number is even and false if the number is odd.
- Create a function that return String of number formatted. Input: 100000 - Output: "100.000".

<details>
  <summary>Odd or Even Function Spoiler</summary>
  
  ```swift
  func isEven(number: Int) -> Bool {
      if number % 2 == 0 {
          return true
      } else {
          return false
      }
  }
  ```

  - Function is receive number as input and boolean as output
  - Return true if the inputted number mod 2 is equals zero
</details>

<details>
  <summary> Number Formatter Function Spoiler</summary>

  ```swift
  func numberFormatter(number: Int, separator: String = ".", currency: String = "Rp") -> String {
      guard number > 0 else {
          return "\(currency) \(number)"
      }

      var copyNumber = number
      var result: [String] = []
      while copyNumber > 0 {
          let lastNumber = copyNumber % 1000
          copyNumber = copyNumber / 1000

          if lastNumber == 0 {
              result.insert("000", at: 0)
          } else if lastNumber < 10 && copyNumber > 0 {
              result.insert("00\(lastNumber)", at: 0)
          } else if lastNumber < 100 && copyNumber > 0 {
              result.insert("0\(lastNumber)", at: 0)
          } else {
              result.insert("\(lastNumber)", at: 0)
          }

          if copyNumber > 0 {
              result.insert(separator, at: 0)
          }
      }

      return "\(currency) \(result.joined())"
  }
  ```

  - Function is receive number, separator, and current as parameter and will return String
  - Return currency with number if the number equals zero
  - Loop per 3 last digit and insert it to the Array of String
  - Add separator every loop and if the number still more than 0
  - Join the array to become a String and return the function
</details>

If you have done create both function without looking at the spoiler, congratulation! if you still stuck you can copy the function above. 
Now some questions, how do you testing the function? Have you make sure the function covered all use cases like negative case and positive case?

> Unit Test is tool to make sure you as a developer testing all use cases of function or business logic in your software, Pretty simple right? 

### Test Your Code
Before we put or bind the function to our UI, put the unit testing is always a good way, now open `1-Basic-WithoutPattern.swift` file.

Initialize the class we want to test:
```swift
import XCTest
@testable import TPWorkshopUnitTest

class __Basic_WithoutPattern: XCTestCase {
    var vc: FirstBasicViewController!
    
    override func setUpWithError() throws {
        vc = FirstBasicViewController(nibName: "FirstBasicViewController", bundle: nil)
        vc.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        vc = nil
    }
}
```

Describe the use case
| Function | Input | Output |
|----------|-------|--------|
| isEven | 2 | isEven true |
| isEven | 3 | isEven false |
| numberFormatter | input: 10 | should return String of Rp 10 |
| numberFormatter | input: 100 | should return String of Rp 100 |
| numberFormatter | input: 1000 | should return String of Rp 1.000 |
| numberFormatter | input: 10000 | should return String of Rp 10.000 |
| numberFormatter | input: 100000 | should return String of Rp 100.000 |
| numberFormatter | input: 1000000 | should return String of Rp 1.000.000 |
| numberFormatter | input: 1000 currency: $ | should return String of $ 1.000 |

You can add more use cases, in Unit Test more you cover the use cases it can prove your function is good enough.

Add Unit Test
```swift
    func test_isEven_odd() throws {
        let isOdd = vc.isEven(number: 3)
        XCTAssertFalse(isOdd, "found even number")
    }
    
    func test_isEven_even() {
        let isEven = vc.isEven(number: 2)
        XCTAssertTrue(isEven, "found odd number")
    }
    
    func test_numberFormatter_tens_withZero() {
        let numberFormatted = vc.numberFormatter(number: 10)
        XCTAssertEqual(numberFormatted, "Rp 10")
    }
    
    // put another use case
```
- XCTAssertFalse - Expect the value should be false, test will failing when function returning true. When test failing, you will got message "found even number".
- XCTAssertTrue - Expect the value should be true, test will failing when function returning false. When test failing, you will got message "found odd number".
- XCTAssertEqual - Expect the value should be equal with the expected value.

Try run `cmd + u` and see the result, if all-green then congrats your test all-passed 🥳

*try to change the logic of your function and run `cmd + u` and see what happen*

### Bind to UI
Our test passed all use cases and ready to use on our UI, it's time to bind it to our UI

Bind button action to `isEven` function
```swift
   @IBAction func didTapFindOddEven(_ sender: Any) {
        guard let oddEvenText = oddEvenTextField.text, !oddEvenText.isEmpty, let number = Int(oddEvenText) else {
            oddEvenResultLabel.text = "Not number"
            return
        }
        
        if isEven(number: number) {
            oddEvenResultLabel.text = "Genap"
        } else {
            oddEvenResultLabel.text = "Ganjil"
        }
    }
```

Bind text selection to `numberFormatting` function
```swift
extension FirstBasicViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let numberFormatterText = textField.text, !numberFormatterText.isEmpty, let number = Int(numberFormatterText) else {
            numberFormatterResultLabel.text = "Not number"
            return
        }
        
        numberFormatterResultLabel.text = numberFormatter(number: number)
    }
}
```

That's it, run the application and see the resut. As your logic wrapped with high quality of unit test, your quality of apps is increase without you need to test it manually.

## Session 2 - Leverage with Design Pattern
| Problem |
|---------|
|We need an application to detect the odd or even number and format the input number to readable format. We need to start it in `SecondBasicViewController.swift` and achieve the goal. But, the company need us to make the code scalable and easy to maintain so it easier to code when we're having alot of feature in the future.|

If you reach this stage, first I wanna say congratulation! I hope you get understanding of basic unit test. Did you found the problem from the first stage? because I do, if we're looking at the code base, imagine we will have another business logic there, our code will messy because we're not separate business logic and the view.
So, how to solve it so we can solve the problem in this session too?

> *The wise man said: SEPARATE THE CODE*

Okay, I heard you wise man, so our job now is separate business logic and view to different class. We know alot of design pattern like MVC, MVVM, VIPER, or TCA and every design pattern always said `easier to testing` beside the separation of the code surely. In this session we will use MVVM (Model View ViewModel) let's start.

Create the ViewModel Class
```swift
struct SecondBasicViewModel { }
```

Define the Output
```swift
    // MARK: Output
    var resultOddEven: ((String) -> Void)?
    var resultNumberFormatter: ((String) -> Void)?
```

Define the Input
```swift
func isEven(text: String?) { }
func numberFormatter(text: String?, separator: String = ".", currency: String = "Rp") { }
```

Put previous logic to the input
```swift
   func isEven(text: String?) {
        guard let numberString = text, !numberString.isEmpty, let number = Int(numberString) else {
            resultOddEven?("Please put number")
            return
        }
        
        if number % 2 == 0 {
            resultOddEven?("Genap")
        } else {
            resultOddEven?("Ganjil")
        }
    }
    
    func numberFormatter(text: String?, separator: String = ".", currency: String = "Rp") {
        guard let numberString = text, !numberString.isEmpty, let number = Int(numberString) else {
            resultNumberFormatter?("Please put number")
            return
        }
        
        guard number > 0 else {
            resultNumberFormatter?("\(currency) \(number)")
            return
        }
        
        var copyNumber = number
        var result: [String] = []
        while copyNumber > 0 {
            let lastNumber = copyNumber % 1000
            copyNumber = copyNumber / 1000
            
            if lastNumber == 0 {
                result.insert("000", at: 0)
            } else if lastNumber < 10 && copyNumber > 0 {
                result.insert("00\(lastNumber)", at: 0)
            } else if lastNumber < 100 && copyNumber > 0 {
                result.insert("0\(lastNumber)", at: 0)
            } else {
                result.insert("\(lastNumber)", at: 0)
            }
            
            if copyNumber > 0 {
                result.insert(separator, at: 0)
            }
        }
        
        resultNumberFormatter?("\(currency) \(result.joined())")
    }
```

- Instead of returning the result, we pass the result to the output which is we're using closure on here.
- We change the parameter to receive the optional string, so we can centralize the logic in the business logic.

That's all, we have moved the business logic to the own class. It's time to test it!
### Test Your Code
Just like previous session, jump to `2-Basic-WithPattern.swift` and add our Unit Test there, don't forget to describe the use case first!

Define the ViewModel Class
```swift
    var viewModel: SecondBasicViewModel!
    override func setUp() {
        viewModel = SecondBasicViewModel()
    }
```

Test isEven Input
```swift
    func test_isEven_odd() {
        let expect = expectation(description: "check if isEven returning Ganjil")
        viewModel.resultOddEven = { result in
            XCTAssertEqual(result, "Ganjil")
            expect.fulfill()
        }
        
        viewModel.isEven(text: "33")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_isEven_even() {
        let expect = expectation(description: "check if isEven returning Genap")
        viewModel.resultOddEven = { result in
            XCTAssertEqual(result, "Genap")
            expect.fulfill()
        }
        
        viewModel.isEven(text: "32")
        waitForExpectations(timeout: 1, handler: nil)
    }
```

- expectation is use when your logic have async jobs, the UT will wait up to 1 sec before it goes failed. Don't forget to put `fulfill` when you got the result.

Test numberFormatter Input
```swift
    func test_numberFormatter_tens_withZero() {
        let expect = expectation(description: "number formatter return tens with zero")
        viewModel.resultNumberFormatter = { result in
            XCTAssertEqual(result, "Rp 10")
            expect.fulfill()
        }
        
        viewModel.numberFormatter(text: "10")
        waitForExpectations(timeout: 1, handler: nil)
    }
```

That's it, you can add more use case and don't forget to `cmd + u` and make sure everything is passed!

### Bind to UI
Back to `SecondBasicViewController` class, it looks like cleaner than before right? yes because we put all logic on another class, our job now is to bind the class to the UI / View layer

Define ViewModel
```swift
var viewModel = SecondBasicViewModel()
```

Bind the Output
```swift
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Second Basic"
        numberFormatterTextField.delegate = self
        
        viewModel.resultOddEven = { [weak self] result in
            self?.oddEvenResultLabel.text = result
        }
        
        viewModel.resultNumberFormatter = { [weak self] result in
            self?.numberFormatterResultLabel.text = result
        }
    }
```

Bind Odd/Even Button Action to the Input
```swift
    @IBAction func didTapFindOddEven(_ sender: Any) {
        viewModel.isEven(text: oddEvenTextField.text)
    }
```

Bind textField action to the Input
```swift
extension SecondBasicViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.numberFormatter(text: textField.text)
    }
}
```

We're done, now Run your application and see the result still the same like on previous session but our code much much better right? We just unlock our level to having knowledge of design pattern along with the Unit Test 🥳
## Session 3 - Advance Unit Test

## Session 4 - Train What You Learn!
