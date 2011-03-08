/*globals console sparks $ breadModel getBreadBoard */

(function() {
  sparks.SparksPageController = function(){
    this.qc = new sparks.SparksQuestionController();
  };
  
  sparks.SparksPageController.prototype = {
    
    createPage: function(jsonPage) {
      var page = new sparks.SparksPage();
      
      page.questions = this.qc.createQuestionsArray(jsonPage.questions);
      page.currentQuestion = page.questions[0];
      
      if (!!jsonPage.notes){
        var notes = sparks.mathParser.calculateMeasurement(jsonPage.notes);
        page.notes = notes;
      }
      
      page.view = new sparks.SparksPageView(page);
      
      return page;
    },
    
    nextQuestion: function(page) {
      for (var i = 0; i < page.questions.length; i++){
        if (page.questions[i] === page.currentQuestion){
          if (i < page.questions.length){
            page.currentQuestion = page.questions[i+1];
            return true;
          } else {
            return false;
          }
        }
      }
      return false;
    },
    
    createReportForPage: function(page) {
      var self = this;
      $.each(page.questions, function(i, question){
        self.qc.gradeQuestion(question);
      });
      
      var $report = $('<table>').addClass('reportTable');
      
      $report.append(
        $('<tr>').append(
          $('<th>').text("Question"),
          $('<th>').text("Your answer"),
          $('<th>').text("Correct answer"),
          $('<th>').text("Score"),
          $('<th>').text("Notes")
        )
      );
      
      var totalScore = 0;
      var totalPossibleScore = 0;
        
      $.each(page.questions, function(i, question){
        var answer = !!question.answer ? question.answer + (!!question.units ? " "+question.units : '') : '';
        var correctAnswer = question.correct_answer + (!!question.correct_units ? " "+question.correct_units : '');
        var score = question.points_earned;
        totalScore += score;
        totalPossibleScore += question.points;
        var feedback = "";

        
        if(!question.feedback){
        	if (answer === '') {
          
        	} else if (!question.answerIsCorrect){
        	  feedback += "The value was wrong";
        	}
        } else {
          feedback = question.feedback;
        }
       
        $report.append(
          $('<tr>').append(
            $('<td>').html(question.shortPrompt),
            $('<td>').html(answer),
            $('<td>').html(correctAnswer),
            $('<td>').html(score +"/" + question.points),
            $('<td>').html(feedback)
          ).addClass(question.answerIsCorrect ? "correct" : "incorrect")
        );
      });
      
      $report.append(
        $('<tr>').append(
          $('<th>').text("Total Score:"),
          $('<th>').text(""),
          $('<th>').text(""),
          $('<th>').text(totalScore + "/" + totalPossibleScore),
          $('<th>').text("")
        )
      );
      
      return $report;
    }
    
  };
})();