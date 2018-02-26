# QUESTIONS API

In this document you will find information resume about cosa1, cosa2, cosa 3

## Requirements
The minimum requirements to run this project are:
* Ruby: v 2.3.3
* Ruby On Rails: v 5.1.5
* Docker compose: v 3
## Previous background
Some concepts very useful to understand how it runs are:
* API RESTFUL
* TDD and BDD(Rspec Documentation)

## Configuration
### To update the database run:
 ```bash 
sudo docker-compose run web rails db:create
sudo docker-compose run web rails db:migrate
sudo docker-compose run web rails db:test:prepare
```

To initilize with a couple of questions:
* ```sudo docker-compose run web rails db:seeds```

### How to run the test suite
To run the test suite is necessary run:
* ```sudo docker-compose run web bundle exec rspec spec```

### Deployment instructions
Different enpoints are:
* post /quizzes
To create a couple of quizzes and questions, the params have the next structure:
```ruby
  params {
    subject: "Mathematics", questions_attributes: [
      {context: "What is 26 + 1?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
      {context: "What is 24 + 2?", real_answer: "B", options: {"A"=>"27", "B"=>"26", "C"=>"23"}}
    ]
  }
```
*  get /quizzes/:id
  to return all information in a quiz where the :id is the quiz id
*  put /quizzes/:id, params: @params
  to update something information in a quiz where the :id is the quiz id, and the structure params are:
  params {
    subject: "Mathematics", questions_attributes: [
      {context: "What is 26 + 1?", real_answer: "A", options: {"A"=>"27", "B"=>"22", "C"=>"23"}},
      {context: "What is 24 + 2?", real_answer: "B", options: {"A"=>"27", "B"=>"26", "C"=>"23"}}
    ]
  }

  to Graded one quiz:

* post "/graded_quizzes", params: @params
  to create a Graded_Quiz where the params are:

  @params = { graded_quiz: {
    quiz_id: @quiz.id, author: "Juanito", answer_attributes: [
      {question_id: @qt3.id, user_answer: "D"},
      {question_id: @qt1.id, user_answer: "A"},
      {question_id: @qt2.id, user_answer: "B"}
    ]
  }


* put /graded_quizzes/:id
  to show the summit of one question and the score, the :id is the Graded Quiz id
