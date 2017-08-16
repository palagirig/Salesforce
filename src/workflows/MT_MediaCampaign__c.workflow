<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>MT_SendsAnEmailToIMA</fullName>
        <description>Sends an Email to IMA</description>
        <protected>false</protected>
        <recipients>
            <field>MT_IMAMail__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/MT_SendMailToIMAAfterCampaignCreation</template>
    </alerts>
    <fieldUpdates>
        <fullName>MT_ChangeSignedFieldToFalse</fullName>
        <field>MT_IsContractSigned__c</field>
        <literalValue>0</literalValue>
        <name>MT Change Signed field to false</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MT_FillIMAMailField</fullName>
        <field>MT_IMAMail__c</field>
        <formula>MT_MediaCampaignType_ref__r.MT_Asset_ref__r.MT_IMAMail__c</formula>
        <name>Fill IMA Mail Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MT_UpdateCampaignStatusField</fullName>
        <field>MT_Status__c</field>
        <literalValue>Completed</literalValue>
        <name>Update Campaign Status field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>MT Campaign Status changed from Approved to</fullName>
        <actions>
            <name>MT_ChangeSignedFieldToFalse</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>When the Campaign status changes from approved to something different the checkbox will be unchecked</description>
        <formula>AND(ISCHANGED(MT_Status__c),MT_IsContractSigned__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MT Campaign Status changed to completed by TV runtime end</fullName>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>MT_MediaCampaign__c.MT_RunTimeTVEnd__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>MT_MediaCampaign__c.MT_ContractEnddate__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>MT_UpdateCampaignStatusField</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>MT_MediaCampaign__c.MT_RunTimeTVEnd__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>MT Campaign Status changed to completed by contract end</fullName>
        <active>true</active>
        <criteriaItems>
            <field>MT_MediaCampaign__c.MT_ContractEnddate__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>MT_UpdateCampaignStatusField</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>MT_MediaCampaign__c.MT_ContractEnddate__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Send Mail to IMA after creation</fullName>
        <actions>
            <name>MT_SendsAnEmailToIMA</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>MT_FillIMAMailField</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( MT_MediaCampaignType_ref__r.MT_Asset_ref__r.MT_IMAMail__c &lt;&gt; null,  RecordType.DeveloperName = &apos;MT_InternalMediaCampaign&apos;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
