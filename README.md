# Overleaf

My final project for Mobile Software Development is a self-proposed app that mimics the functionality of Overleaf, a collaborative cloud-based editor used for writing, editing and publishing documents. 

## Goals 

### Initial Proposal 

I have been using Overleaf since I started at UChicago for many physics, economics, and math psets. It is an extremely helpful website and its one flaw is that it is _only_ that. There is no Overleaf app, so in order to modify the documents I have stored in Overleaf when I'm on the go, I have to open up a browser tab on my device and navigate to the Overleaf website. Although the website does its best to adjust to make the user's experience pleasant on a phone, it would be helpful to have an app version that is intended for smaller screens.This project is a starting point for what can hopefully eventually become a thoroughly built out, usable Overleaf iOS app.

### Project Features 

1) Easy to navigate file system UI
2) Create new files and delete unwanted ones files
3) Real time markdown compiling using Down implementation
4) Automatically date each document that's created
5) Drag and drop the files to arrange them in the order you want
6) Editable cells that allow you to go back and edit your documents, changes are automatically saved

### Lessons Learned

I went through many different packages that claimed to support Markdown rendering in SwiftUI. The lack of documentation made it particularly difficult to figureout how each package worked and how I could implement it in the structures I'd already set up. After to trying a split screen real time text compile that kept on failing, I decided to go back to my simpler, original idea in the hopes that Icould at least get that working. Eventually, I found a package that was reliable and had a git that was a bit easier to understand. Throughout this project, I've come to appreciate the importance of good documentation and am more committed to making my work easy for others to understand in the future. Here are some interesting Swift tools that I learned how to use in order to build out this project: 
	- Markdown rendering in TextView

### Looking Forward 

Looking forward, I hope that the time I spend on this app is dedicated to makingthe code accessible and easy to parse through. Now that I know exactly how I can get the desired features working, I can adjust the structure of my code so that it's cleaner and more efficient. It would also be nice if the app was linked to your actual Overleaf account. 

## References 

Andrew Zhang's Medium article on how to build a Markdown editor was helpful. I also often referenced the iOS list app we worked on in class for the file system framework as well as Swift documentation.  

## Demo


https://github.com/sophiahchiang/overleaf/assets/67343609/bd5e8608-a331-48fb-84cd-233e10099515



