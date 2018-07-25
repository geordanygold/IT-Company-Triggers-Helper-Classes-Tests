trigger TotalBillableProjects2 on Project__c (before insert, after insert, before update, after update, 
                                             before delete, after delete, after undelete) {

    List <Id> projects = new List <Id>();

    if(Trigger.isInsert){
        
        For( Project__c projNew : Trigger.new ){

                    projects.add(projNew.Id);
                    system.debug('Projects after insert ' + projNew);               
        }
    }

    else if(Trigger.isAfter){
        if(Trigger.isUpdate){

            For( Project__c projNew : Trigger.new ){

                Project__c projOld = Trigger.oldMap.get(projNew.Id);

                if( projNew.Active__c != projOld.Active__c ||
                    projNew.IsBillable__c != projOld.IsBillable__c ){

                        projects.add(projNew.Id);
                        system.debug('Projects after update ' + projNew);
                }
            }
        }

        else if(Trigger.isDelete){

            For( Project__c projOld : Trigger.old ){
                projects.add(projOld.Id);
                system.debug('Projects after delete ' + projOld);
            }
        }
    }

    else if(Trigger.isUndelete){

        For( Project__c projNew : Trigger.new ){
            projects.add(projNew.Id);
        }
    }


    if( !projects.isEmpty() ){
        system.debug('This is projects ' + projects);

        List <Id> devsIds = new List <Id>();
        List <Id> projectsFromAllAssignmentsDevsIds = new List <Id>();

// get devsIds through Project_Assignment__c

        List <Project_Assignment__c> projAsses = [Select Id, Developer__c 
                                                    From Project_Assignment__c
                                                    Where Project__c IN : projects];

        For( Project_Assignment__c projAss : projAsses){

            devsIds.add(projAss.Developer__c);
        }
        
        CountDevsBilliablePrijects devsToUpdate = TotalBilliableProjectsHelper.countProjects( devsIds );
        update devsToUpdate.devsWithProjects;
        update devsToUpdate.devsWithoutVAlidProjects;

    }
}