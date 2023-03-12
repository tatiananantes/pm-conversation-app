# Task
Use Ruby on Rails to build a project conversation history. A user should be able to:
- leave a comment
- change the status of the project
The project conversation history should list comments and changes in status. 

## Requirements

Q:User permissions: Can users leave comments on any project or only on specific projects?
A: Users can leave comments on any project but can only edit their own even after they have been posted. Comments can not be deleted. 

Q: Will this application be accessible without a login? 
A: Access to the application will be done through registration/login. 

Q:What are the possible status options for a project?
A: The possible status options for a project are "Not Started", "In progress", "Completed", and "Stalled".

Q: Can users change the status of any project or only specific projects?
A: Users can only change the status of their projects (same with other edits). 

Q: Should the conversation history display comments/status changes in chronological order?
A: Yes, the conversation history should display comments/status changes in chronological order. It should also display which user commented. 

Q: Are there any specific design requirements for the conversation history page?
A: No, there are no specific design requirements for the conversation history page.

Q: What is the minimum test coverage?
A: >95% 

## Demo video
[You can watch a demo video of the app here](https://watch.screencastify.com/v/vFEWIoLF8KWY7zEr0DSY)

## Code Coverage
<img width="823" alt="image" src="https://user-images.githubusercontent.com/10349072/224581206-898c011b-eda8-4713-9baa-4b62ce68b225.png">


## Screenshots
![image](https://user-images.githubusercontent.com/10349072/224578763-b77f04ee-776d-4f6d-8183-291fbb64b753.png)
![image](https://user-images.githubusercontent.com/10349072/224578832-eedb7023-b4e3-4e89-acce-aca24a64e18f.png)
![image](https://user-images.githubusercontent.com/10349072/224578917-296438d5-624c-42b7-9645-5062c6caa48c.png)
![image](https://user-images.githubusercontent.com/10349072/224578945-46e6e2ae-398e-4bba-ade0-5fa91ba723b2.png)
![image](https://user-images.githubusercontent.com/10349072/224578964-f2955efe-34c8-4dab-a3f1-e55de4934860.png)
![image](https://user-images.githubusercontent.com/10349072/224579106-0b49b3fb-211b-45ae-b275-ac09cb2147e2.png)
![image](https://user-images.githubusercontent.com/10349072/224579189-06e37e19-b534-4ae2-b324-f4a0f5d645b5.png)
![image](https://user-images.githubusercontent.com/10349072/224579249-6068a32a-f23a-4d66-92c8-667cb4dec47a.png)
![image](https://user-images.githubusercontent.com/10349072/224579520-97d0863a-9623-40b9-935e-67a173798797.png)

How to run it:
------
```
- clone this repo
- navigate to om-conversation directory
- run bundle to ensure all gems available
- run rspec to check test coverage
- run rails server and navigate to ```http://localhost:3000/```
- create an account, log in with that account and you should be able to create projects and comments
```
