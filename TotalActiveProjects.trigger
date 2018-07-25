trigger TotalActiveProjects on Project__c (before insert, before update, before delete, after insert, 
											after update, after delete, after undelete) {

	LIST <Id> clientsIds = new LIST <Id>();

		if (Trigger.isInsert || Trigger.isUndelete) {
	    	
	    	For( Project__c projNew : Trigger.new ){
	    		clientsIds.add(projNew.Client__c);
	    	}
		} 

		else if (Trigger.isAfter) {
			if(Trigger.isUpdate){

				For( Project__c projNew : Trigger.new ){

					Project__c projOld = Trigger.oldMap.get(projNew.Id);

					if( projOld.Active__c != projNew.Active__c ){
						clientsIds.add(projOld.Client__c);
						clientsIds.add(projNew.Client__c);
					}
				}
			}

			else if(Trigger.isDelete){

				For( Project__c projOld : Trigger.old ){

					clientsIds.add(projOld.Client__c);
				}
			}
		}


		if( !clientsIds.isEmpty() ){

			CountClientsActiveProjects myResult = TotalActiveProjectsHelper.countClActProjes(clientsIds);
			update myResult.clientsActiveProjes;
			update myResult.clientsWithoutActiveProjects;

		}
	
}