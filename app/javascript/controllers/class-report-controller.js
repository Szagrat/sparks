/*globals console sparks $ breadModel getBreadBoard window */

(function() {
  
  /*
   * Sparks Class Report Controller can be accessed by the
   * singleton variable sparks.classReportController
   *
   * There is only one singlton sparks.classReport object. This
   * controller creates it when the controller is created.
   */
  sparks.ClassReportController = function(){
    // sparks.classReport = new sparks.ClassReport();
    this.reports = [];
    // this.view = new sparks.ClassReportView();
  };
  
  sparks.ClassReportController.prototype = {
    
    getClassData: function(activityId, classId, callback) {
      var reports = this.reports;
          
      var receivedData = function(response){
        if (!!response && !!response.rows && response.rows.length > 0){
          for (var i = 0, ii = response.rows.length; i < ii; i++){
            reports.push(response.rows[i].value);
          }
          callback(reports);
        }
      };
      
      var fail = function() {
        alert("Failed to load class report");
      };
      
      sparks.couchDS.loadClassData(activityId, classId, receivedData, fail);
    },
    
    getLevels: function() {
      if (this.reports.length > 0){
        var reportWithMostSections = 0,
            mostSections = 0;
        for (var i = 0, ii = this.reports.length; i < ii; i++){
          var numSections = this.reports[i].sectionReports.length;
          if (numSections > mostSections){
            mostSections = numSections;
            reportWithMostSections = i;
          }
        }
        var sectionReports = this.reports[reportWithMostSections].sectionReports;
        return $.map(sectionReports, function(report, i) {
          return (report.sectionTitle);
        });
      }
      return [];
    }
    
  };
  
  sparks.classReportController = new sparks.ClassReportController();
})();