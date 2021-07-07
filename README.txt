
--------------------------------------
This app is written for demo purpose.
It retrieves and displays cars both on a map and on a list.

Gökhan Mutlu ------------------8<-----

THOUGHTS:
*   JSON data consists of static and instant values. Data is small, cars seem to stay where they are and for demo purpose it is acceptable.
    However in real word scenario cars might be moving, or might need to check locations repeatedly.
    In short, API servis might provide those data with two seperate calls. We will be able to have faster response, less processing, better caching.

*   SwiftUI is latest framework to build Apps on Apple platforms. However, I think staff is using UIKit, and requirements did not specify it, so
    I am going to use UIKit which is also a great framwork. I could reimplement the project with SwiftUI or using other frameworks to mimic MMVM pattern,
    or mixing UIKit and SwiftUI (in real world it might be the inital choice).

*   I'd like to use storyboard because it seems easier to implement for this demo. I can also able to create all UI by code.

*   I make CarDetailView SwiftUI view in order to demostrate how to use both frameworks for possible future scenarios.

*   I check the app with different network conditions via "Network Link Conditioner"

*   To overcome possible performance problems, I think paging will be necessary. But API service is not supporting it. (If it does support, I prefer to implement it).



SceneDelegate.swift
     I inject service client instance in scene(_:,willConnectTo:,options:) method
     
SixtApiClient.swift
    *   I did not prefer to use singleton pattern, which is very common, because I am injecting api client when the app starts,
        and wont be necessary to create it later. Besides SixtApi is just used to fetch data. Any threading issues expected for current scenario(s)

s
