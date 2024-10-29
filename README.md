# Questions in HW:

### Question 1: What issues prevent us from using storyboards in real projects?

Answer: First of all, it prevents merge conflicts, because storyboards are XML files.  
For example, there is an interesting situation described in this article https://medium.com/remote-technologist/avoid-storyboards-and-interface-builder-cc3363de4782

"This is a diff of changes that Xcode made to a storyboard file I opened recently. All I did was look at the storyboard in IB. I didn’t touch a single view, and yet Xcode made dozens of small changes throughout the file"

Another reason to not use storyboard is the fact that Interface Builder files are not reviewable.  

### Question 2: What does the code on lines 25 and 29 do?

Code:
```
17. private func configureUI() {
18. view.backgroundColor = .systemPink
19.
20. configureTitle()
21. }
22.
23. private func configureTitle() {
24. let title = UILabel() // make it a private field titleView above viewDidLoad()
25. title.translatesAutoresizingMaskIntoConstraints = false
26. title.text = "WishMaker"
27. title.font = UIFont.systemFont(ofSize: 32)
28.
29. view.addSubview(title)
30. NSLayoutConstraint.activate([
31. title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
32. title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
33. title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
34. ])
```
Answer: line 25 - it turns off automatic generations of limitations for interface because we want to use Auto Layout
line 29 - adding title to our view  

### Question 3: What is a safe area layout guide?

Answer: It is an area which garantee that objects in this area will be presented and visible across different devices with different displays and orientations  

### Question 4: What is [weak self] on line 23 and why it is important?

Answer: [weak self] is a capture list used to define how self is captured inside the closure assigned to sliderRed.valueChanged.
This line is important because it helps to avoid retain cycle where self is strongly referenced by the closure and the closure itself is owned by self, so afterwards it leads to memory leak   
Also, because of this line self inside the closure is an optional. And if self has been deallocated after  valueChanged is called, self will be nil and the closure won’t attempt to change background color   

### Question 5: What does clipsToBounds mean?

if clipsToBounds = true, it means that objects which placed out of bounds (in our case stack bounds) wont be visible.  

### Question 6: What is the valueChanged type? What is Void and what is Double?

Answer: valueChanged type is an optional closure.

Double: The parameter type of the closure, which represents a Double value passed to the closure when it’s called.  
Void: The return type of the closure, which indicates that the closure does not return any value

 
