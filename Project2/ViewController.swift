//
//  ViewController.swift
//  Project2
//
//  Created by Furkan Eruçar on 27.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]() // The first line is something you saw in project 1: it creates a new property called countries that will hold a new array of strings.
    var score = 0 // The second one creates a new property called score that is set to 0
    var correctAnswer = 0 // Doğru cevap için bir değişken oluşturuyoruz.
    var counter = 0 // bir tane sayaç oluşturduk, bununla gelen soruları sayıcaz
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // countries.append("estonia")
        // countries.append("france")
        // countries.append("germany")
        // countries.append("ireland")
        // countries.append("italy")
        // countries.append("monaco")
        // countries.append("nigeria")
        // countries.append("poland")
        // countries.append("russia")
        // countries.append("spain")
        // countries.append("uk")
        // countries.append("us")
        
        //Bu şekilde de yapabiliriz ama array yöntemiyle tek satırda yazabiliriz
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1 // Bayraklarımızı koyduk fakat bazı bayrakların renkleriyle arka plan aynı olduğu için ekranda kayboldu, bunun için bayrağın sınırları içerisine bi çerçeve yerleştiriyoruz.
        button2.layer.borderWidth = 1 // Remember how points and pixels are different things? In this case, our border will be 1 pixel on non-retina devices, 2 pixels on retina devices, and 3 on retina HD devices.
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor // CALayer has its own way of setting colors called CGColor, which comes from Apple's Core Graphics framework. As you can see, UIColor has a property called lightGray that returns (shock!) a UIColor instance that represents a light gray color. But we can't put a UIColor into the borderColor property because it belongs to a CALayer, which doesn't understand what a UIColor is. So, we add .cgColor to the end of the UIColor to have it automagically converted to a CGColor. Perfect.
        button2.layer.borderColor = UIColor(red: 1.1, green: 0.6, blue: 0.2, alpha: 1.0).cgColor //default renkler yerine kendimiz de renk verebiliriz. alpha burda opaklık
        button3.layer.borderColor = UIColor.lightGray.cgColor // By default, the border of CALayer is black, but you can change that if you want by using the UIColor data type. Burda da yerleştirdiğimiz çerçevelerin rengini ayarlıyoruz
        
        askQuestion()
        
    }
    
    
    func askQuestion(action: UIAlertAction! = nil) {
        // askQuestion(action: UIAlertAction! ise yukardaki askQuestion(action: nil) olacak
        countries.shuffle() // Bu, arraydeki ülkelerin sırasını otomatik olarak rastgele yapar.
        correctAnswer = Int.random(in: 0...2) // 3 tane elemanımız olduğu için doğru cevap rastgele bu üçünden biri olucak.
        
        
        // The next step is to write a method that shows three random flag images on the screen. Buttons have a setImage() method that lets us control what picture is shown inside and when, so we can use that with UIImage to display our flags. The first line is easy enough: we're declaring a new method called askQuestion(), and it takes no parameters. The next three use UIImage(named:) and read from an array by position, both of which we used in project 1, so that bit isn't new either. However, the rest of those lines is new, and shows off two things:
        
        //That .normal parameter looks like an enum, but it’s actually a static property of a struct called UIControlState.
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)  // button1.setImage() assigns a UIImage to the button. We have the US flag in there right now, but this will change it when askQuestion() is called.
        // for: .normal The setImage() method takes a second parameter that describes which state of the button should be changed. We're specifying .normal, which means "the standard state of the button."
        //That .normal parameter looks like an enum, but it’s actually a static property of a struct called UIControlState.
        
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage((UIImage(named: countries[2])), for: .normal)
        
        title = "Score: \(score), " + "Tap on: " + countries[correctAnswer].uppercased() + "'s Flag" // Kullanıcının score'unu ve seçmesi gereken bayrağı söylüyoruz.
        
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) { // 1. Check whether the answer was correct.
        // 2. Adjust the player's score up or down.
        // 3. Show a message telling them what their new score is
        
        var title: String
        
        if sender.tag == correctAnswer { // But how do we know whether the correct button was tapped? Right now, all the buttons look the same, but behind the scenes all views have a special identifying number that we can set, called its Tag. This can be any number you want, so we're going to give our buttons the numbers 0, 1 and 2. This isn't a coincidence: our code is already set to put flags 0, 1 and 2 into those buttons, so if we give them the same tags we know exactly what flag was tapped.
            title = "Correct"
            score += 1
            counter += 1 // Burada ve aşağıda yazdığımız gibi, doğru da olsa yanlış da olsa sayaç işlicek
        } else {
            title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())" // Eğer kullanıcı yanlış bayrağı seçerse, seçtiği bayrağın ismini gösterecek.
            score -= 1
            counter += 1
        }
        
        if counter == 6 { // ve sayaç 10'a ulaşınca ilk mesaj gösterilecek.
            let acFinish = UIAlertController(title: title, message: "GAME OVER! Your Score is \(score)", preferredStyle: .alert) // UIAlertController() is used to show an alert with options to the user. First new thing there is the .alert parameter being used for preferredStyle. preferredStyle hangi şekille bildirim göstereceğini gösteriyor. Burada Closure yaptık
            acFinish.addAction(UIAlertAction(title: "START AGAIN", style: .default, handler: askQuestion)) // The second line uses the UIAlertAction data type to add a button to the alert that says "Continue", and gives it the style “default". önceden hatırlarsak 3 çeşit style vardı: .default, .cancel, .destructive. The "handler" parameter is looking for a closure, which is some code that it can execute when the button is tapped. We want the game to continue when the button is tapped, so we pass in askQuestion so that iOS will call our askQuestion() method.
            present(acFinish, animated: true)
            score = 0
            counter = 0
            
        } else {
            
            let ac = UIAlertController(title: title, message: "your score is \(score)", preferredStyle: .alert) // UIAlertController() is used to show an alert with options to the user. First new thing there is the .alert parameter being used for preferredStyle. preferredStyle hangi şekille bildirim göstereceğini gösteriyor. Burada Closure yaptık
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion)) // The second line uses the UIAlertAction data type to add a button to the alert that says "Continue", and gives it the style “default". önceden hatırlarsak 3 çeşit style vardı: .default, .cancel, .destructive. The "handler" parameter is looking for a closure, which is some code that it can execute when the button is tapped. We want the game to continue when the button is tapped, so we pass in askQuestion so that iOS will call our askQuestion() method.
            present(ac, animated: true) // The final line calls present(), which takes two parameters: a view controller to present and whether to animate the presentation.
        }
    }
    
    @IBAction func scoreButtonTapped(_ sender: UIBarButtonItem) {
        
        let scoreAlert = UIAlertController(title: "Your score is \(score) ", message: nil, preferredStyle: .alert)
        
        scoreAlert.addAction(UIAlertAction(title: "Continue Playing", style: .cancel))
        present(scoreAlert, animated: true)
    
    }
        
        
    
    
    
}
    
    //        let ac = UIAlertController(title: title, message: "your score is \(score)", preferredStyle: .alert) // UIAlertController() is used to show an alert with options to the user. First new thing there is the .alert parameter being used for preferredStyle. preferredStyle hangi şekille bildirim göstereceğini gösteriyor. Burada Closure yaptık
    //        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion)) // The second line uses the UIAlertAction data type to add a button to the alert that says "Continue", and gives it the style “default". önceden hatırlarsak 3 çeşit style vardı: .default, .cancel, .destructive. The "handler" parameter is looking for a closure, which is some code that it can execute when the button is tapped. We want the game to continue when the button is tapped, so we pass in askQuestion so that iOS will call our askQuestion() method.
    //        present(ac, animated: true) // The final line calls present(), which takes two parameters: a view controller to present and whether to animate the presentation.



