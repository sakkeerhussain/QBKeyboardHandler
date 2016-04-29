# QBKeyboardHandler
View Controller which includes basic keyboard handling in iOS. 

#Features
* Handles keyboard hide in outside click.
* Handles Next button in keyboard.
* Handles Return button in keyboard.
* Handles keyboard hides some portion of content issue.

#Usage
* Extend your base view controller or view controllers for those this feature requires from "QBBaseViewController" instead on "UIViewCotroller"

@interface ViewController : QBBaseViewController 

* Assign your parents bottom constraint to "bottomMarginConstraint". Keep its value 0 by default.

