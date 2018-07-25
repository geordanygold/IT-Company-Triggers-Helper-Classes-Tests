public class TotalBilliableProjectsHelper {
   
    public static CountDevsBilliablePrijects countProjects ( LIST <Id> devsIds ) {
        
        CountDevsBilliablePrijects myResult = new CountDevsBilliablePrijects();
        
        List <Id> projectsFromAllAssignmentsDevsIds = new List <Id>();
        
        List <Project__c> allProjects = [Select Id, Active__c, IsBillable__c 
                                         From Project__c
                                         Where Id IN (Select Project__c From Project_Assignment__c Where Developer__c IN : devsIds)];
        
        List <Project__c> validProjects = new List <Project__c>();
        List <Id> validProjectsDevs = new List <Id>();       
        
        FOR( Project__c proj : allProjects ){
            
            if( proj.Active__c == TRUE && proj.IsBillable__c == TRUE ){          
                validProjects.add(proj);           
            }
        }                                    
										

		LIST <AggregateResult> countProjes = [Select Developer__c, COUNT(Id)total
                                              From Project_Assignment__c
                                              Where Project__c IN : validProjects 
                                              GROUP BY Developer__c];
  
        system.debug('Count valid projects for every dev ' + countProjes);
        
        For( AggregateResult agg : countProjes ){
            
            myResult.devsWithProjects.add( new Developer__c (
                
                Id = (Id)agg.get('Developer__c'),
                TotalBillableProjects__c = (Integer)agg.get('total')
            ));
            
            validProjectsDevs.add( (Id)agg.get('Developer__c') );
        }
        
        
        myResult.devsWithoutVAlidProjects = [Select Id, TotalBillableProjects__c From Developer__c Where Id NOT IN : validProjectsDevs];
        
        FOR( Developer__c dev : myResult.devsWithoutVAlidProjects ){
            dev.TotalBillableProjects__c = 0;
        }

		return myResult;
    }
    

}