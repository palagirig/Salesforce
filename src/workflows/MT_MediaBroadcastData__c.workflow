<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>MT_MediaBroadcastData_PopulateType</fullName>
        <field>MT_BroadcastType__c</field>
        <formula>MT_ProSaOrder_ref__r.RecordType.Name</formula>
        <name>MT_MediaBroadcastData_PopulateType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>MT_MediaBroadcastData_PopulateDependentFields</fullName>
        <actions>
            <name>MT_MediaBroadcastData_PopulateType</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>MT_MediaBroadcastData__c.MT_ProSaOrder_Type__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
