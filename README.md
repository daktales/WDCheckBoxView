WDCheckBoxView
======
You can use the WDCheckBoxView class to create and manage checkboxes.
 
 ![Checked example](https://dl.dropboxusercontent.com/u/515180/github/WdCheckBoxView/Screenshot%202013-11-08%2009.43.57.png)
 ![Unchecked example](https://dl.dropboxusercontent.com/u/515180/github/WdCheckBoxView/Screenshot%202013-11-08%2009.44.24.png)
 
*(On the left the default customisation)*
 
###Description
This component is customisable and provide two animations:

- one for switching between checked/unchecked state
- one for highlight

There is a lot of room for appearance customisation using `UI_APPEARANCE_SELECTOR` but, if you want more, you must play with Bezier paths category.

All animations can be disabled and you can resize it from 0 to infinite (auto layout support).

When checked/unchecked state change an `UIControlEventValueChanged` will be raised so you can track it.
###Note
This component has been made to learn something about layers and CoreAnimation.

I don't have pro skill with CA and I am pretty sure that a better way to do things always exists, but we must start with something.
 
##Preview
[![Example](https://dl.dropboxusercontent.com/u/515180/github/WdCheckBoxView/WDCheckBoxMovie.gif)](https://dl.dropboxusercontent.com/u/515180/github/WdCheckBoxView/WDCheckBoxMovie.mov)
##Usage

    #import "WDCheckBoxView.h"
    - (void) viewDidLoad {
        [super viewDidLoad];
        WDCheckBoxView *checkboxView = [[WDCheckBoxView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
        [self.view addSubview:checkboxView];
        [checkboxView addTarget:self action:@selector(pressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    - (void) pressed:(WDCheckBoxView *)sender{
        [sender setChecked:!sender.checked animated:YES];
    }

##Prerequisite
WDCheckBoxView is compatible with ARC and use this frameworks:

* Foundation.framework
* UIKit.framework
* CoreGraphics.framework
* QuartzCore.framework

##Install

### Basic
Simply download it from [here](https://github.com/daktales/WDCheckBoxView/archive/master.zip) and include it in your project manually.

### GIT submodule

You have the canonical `git submodule` option. Simply issue

    git submodule add https://github.com/daktales/WDCheckBoxView.git <path>

in your root folder of your repository.

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE). 
