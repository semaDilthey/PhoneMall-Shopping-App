# PhoneMall-Shopping-App

This is a test assignment. It represents a concept of an online electronics store. MVVM + Coordinator architecture was used in its creation. A custom API was implemented to retrieve data.

## Prototype:  [FIGMA](https://www.figma.com/file/KqZcU5m3GMxAHwgFkvCONz/ECOMMERCE?node-id=2%3A845)
<details>
  <summary><b>The stack I used in this work</b></summary>

1. **Programming Language:**
   - Swift.
2. **Frameworks and Libraries:**
   - UIKit.
   - Foundation.
   - CompositionalLayout
   - UserDefaults

3. **Architectural Pattern:**
   - MVVM (Model-View-ViewModel).

4. **User Interface:**
   - Programmatically.
     
5.  **Data Handling:**
   - Working with RESTful API.
   - Knowledge of data formats (JSON).

7. **Testing:**
   - Unit testing (XCTest) - In process.

8. **Development Tools:**
   - Xcode.
   - Interface Builder.
   - Git.

9. **Working with Third-Party Libraries and Dependencies:**
    - CocoaPods.
    - Swift Package Manager.
    </details>

## Main screen
Retrieving information from the API and passing it to collection view cells. Utilizing UICompositionalLayout for layout.

### Select category
* When a cell is tapped, its color changes as intended. Only one icon can be selected and highlighted.
### Hot sales 
* carousel of elements.
### Best seller 
* By tappind hot sales or best seller cell presenting detail controller

 ## Presentation
  ### MainScreen

![MainScreen](https://github.com/semaDilthey/PhoneMall-Shopping-App/assets/128741166/00e35154-c20b-4086-8270-fa1f96cff84d)


### Filter options

* picker list of brands, prices and sizes

![FilterVC](https://github.com/semaDilthey/PhoneMall-Shopping-App/assets/128741166/46b2cfb7-670e-4046-ba7b-e829ff6e3bf1)

### Details screen

* There is an option to load everything from a single API, but according to the technical specifications, we use a separate API for each screen. Hence, there is only one phone model.
* 
![DetailsVC](https://github.com/semaDilthey/PhoneMall-Shopping-App/assets/128741166/5d42a52e-f7fb-4e54-a632-c9c0d44272ec)
