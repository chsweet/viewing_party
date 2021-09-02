<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->

<!-- PROJECT LOGO -->
![Asset 2film](https://user-images.githubusercontent.com/42476338/131891086-40a85298-c940-4bfe-9dd4-0494f6960417.png)
<br />
  <h3 align="center">Movie Night</h3>

  <p align="center">
    A fun online application to watch movies with your friends!
  </p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#tools-used">Tools Used</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

![Movie Night Screenshot](https://user-images.githubusercontent.com/42476338/131887219-04e4594f-72bc-4fd0-867f-f363b0c97b38.png)
Movie Night is an application where users can create a viewing party event for the user and friends. Movie Night uses The Movie Database API to create search functionality to find all your favorite movies. 


Learning Goals:
* Consume JSON API that requires authentication
* Build an application that requires basic authentication
* Implement a self-referential relationship
* Organize and refactor code to make it more maintainable
* Implement Javascript functionality on front end. 


## Tools Used

| Development | Testing       | Gems            |
|   :----:    |    :----:     |    :----:       |
| Ruby 2.7.2  | RSpec         | Pry             |
| Rails 5.2.5 | WebMock       | ShouldaMatchers |
| HTML5       | VCR           | Capybara        |
| CSS3        | Launchy       | Figaro          |
| Javascript  | SimpleCov     | BCrypt          |
| Atom        | Capybara      | geckodriver     |
| Github      | Selenium      |                 |
|             | FactoryBot    |                 |


<!-- GETTING STARTED -->
## Getting Started

To run this project localy please follow the instructions below. For production environment go to: [Movie Night](https://glacial-ridge-45838.herokuapp.com/)


### Installation

1. Get a free API Key at [The Movie Database API](https://developers.themoviedb.org/3/getting-started/introduction)
2. Clone the repo
   ```sh
   git clone https://github.com/chsweet/viewing_party.git
   ```
3. Install gems
   ```sh
   bundle install
   ```
4. Install figaro
    ```sh
   bundle exec figaro install
   ```
5. Enter your API in `application.yml`
   ```ruby
   movie_api_key = <ENTER YOUR API>
   ```
6. Setup the database
    ```sh
   rails db:create
   rails db:migrate
   ```



<!-- USAGE EXAMPLES -->
## Usage

Movie Night can be used to connect with your friends and schedule watch parties for a movie of your choosing. Both the host and friends you want to invite must be registered with viewing party to use full functionality of the app. Access Movie Night [here](https://glacial-ridge-45838.herokuapp.com/).


<!-- CONTACT -->
## Contact
👤  **Carina Sweet**
- [GitHub](https://github.com/chsweet)
- [LinkedIn](https://www.linkedin.com/in/carina-h-sweet/)

👤  **Marla Schulz**
- [GitHub](https://github.com/marlitas)
- [LinkedIn](https://www.linkedin.com/in/marla-a-schulz/)

Project Link: [https://github.com/chsweet/viewing_party](https://github.com/chsweet/viewing_party)


<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [Turing School of Software and Design](https://turing.edu/)
  - Project created for completion towards Backend Engineering Program
* [The Movie Database](https://www.themoviedb.org/)
