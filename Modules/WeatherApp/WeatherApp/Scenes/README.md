The architecture and implementation of "screens" is **heavily** inspired by [(B)VIPER](https://skillsmatter.com/skillscasts/7931-mastering-reuse-a-journey-into-application-modularization-with-viper) and the corresponding [example app](https://github.com/nzaghini/b-viper#bviper-design-example-a-simple-weather-application).

# Differences vs (B)VIPER

1. View is completely isolated from Presenter. View is passive, **doesn't trigger any kind of load** , and forward all the user interaction to the **delegate**. Hence:
    
   * View knows nothing about Presenter, even in the implementation.
   * (Initial) View content loading is triggered as necessary from **module builder**.
   * (Default) Presenter is always delegate of View. *View output* is defined by View Delegate, not by Presenter:
        
      *  Presenter is something *more* than a View Delegate
      *  At least some views should be reusable with **different** Presenters.
    
     Presenter *has* input that matches the output of View, but it might have other dependencies as well (e.g. related to Interactor). Hence we could define View Output in terms of (view facing) Presenter Input, but that is again, *solely* bound to View side, and should be the same for different Presenters for View to be reusable. Hence such a (View Facing) Presenter Input is basically indistinguashable from View Output, that, in case of View is typically View Delegate.
      
   Given all the above, View *implementation* (read: ViewController) is always architecture agnostic: the fact that there're View protocol is just a coincedence. *It just happens* that ViewController implements the module-specific View protocol.
    
2. (Default) Module configuration so far is achieved via `new<ModuleName>ViewController(input1, ... inputN)` or `ModuleName.prepare(viewController, input1, ... inputN)`.

3. It needs to be further investigated how/whether to avoid loading view when dealing with view controller containment (during module configuration). Technically it should be possible to delay it till viewDidLoad, but that would require support from view controller/adding extra dependency.
