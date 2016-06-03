trigger dep1 on Lead (before insert) {
	List<Lead> obj = new List<Lead>([Select id, name,SICCode__c from Lead]);
        list<Lead> updated = new List<Lead>();
        for(Lead l: obj)
        {
            l.SICCode__c = 'TestFromTrigger';
            updated.add(l);
        }
        update updated;
}