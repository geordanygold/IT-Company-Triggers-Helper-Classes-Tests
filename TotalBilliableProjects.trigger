trigger TotalBilliableProjects on Project_Assignment__c (before insert, after insert, before update, after update,
														before delete, after delete, after undelete) {

	List <Id> devsIds = new List <Id>();

	if(Trigger.isInsert){

		For( Project_Assignment__c projAssNew : Trigger.new ){
			devsIds.add(projAssNew.Developer__c);		
		}
	}

	else if(Trigger.isAfter){
		if(Trigger.isUpdate){

			For( Project_Assignment__c projAssNew : Trigger.new ){

				Project_Assignment__c projAssOld = Trigger.oldMap.get(projAssNew.Id);
                
                system.debug('This is old Dev this assignment ' + projAssOld.Developer__c);

				if( projAssOld.Developer__c != projAssNew.Developer__c ){
					devsIds.add(projAssNew.Developer__c);
                    devsIds.add(projAssOld.Developer__c);
                    system.debug('This is new Dev this assignment ' + projAssNew.Developer__c);
				}
			}
		}

		else if(Trigger.isDelete){

			For( Project_Assignment__c projAssOLd : Trigger.old ){
				devsIds.add(projAssOLd.Developer__c);			
			}
		}
	}

	else if(Trigger.isUndelete){

		For( Project_Assignment__c projAssNew : Trigger.new ){
			devsIds.add(projAssNew.Developer__c);
		}
	}


	if( !devsIds.isEmpty() ){
   
        CountDevsBilliablePrijects devsToUpdate = TotalBilliableProjectsHelper.countProjects( devsIds );
        update devsToUpdate.devsWithProjects;
        update devsToUpdate.devsWithoutVAlidProjects;

	}

}