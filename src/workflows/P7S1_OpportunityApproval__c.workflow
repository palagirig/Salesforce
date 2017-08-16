<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Digital_Anteil_Notification</fullName>
        <description>Digital Anteil Notification</description>
        <protected>false</protected>
        <recipients>
            <field>SOM_DigitalSales__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Sales_Excellence_Emails/P7S1_InfoDigitalSales</template>
    </alerts>
    <alerts>
        <fullName>MT_SendMailToMediaBoard</fullName>
        <description>Send Mail to Media Board Group</description>
        <protected>false</protected>
        <recipients>
            <recipient>Media_Board</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/MT_MediaTransparencyCampaignApproval</template>
    </alerts>
    <alerts>
        <fullName>P7S1_OwnerNotificationRabattfreigabeErteilt</fullName>
        <description>Owner Notification Rabattfreigabe erteilt</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Sales_Excellence_Emails/P7S1_SE_RabattfreigabeErteilt</template>
    </alerts>
    <alerts>
        <fullName>P7S1_SendEmailtoDooHSales</fullName>
        <description>Send Email to DooH Sales</description>
        <protected>false</protected>
        <recipients>
            <field>SOM_DooHSales__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Sales_Excellence_Emails/P7S1_InfoDooHSales</template>
    </alerts>
    <fieldUpdates>
        <fullName>Deal_abgelehnt</fullName>
        <field>P7S1_ApprovalState__c</field>
        <literalValue>Abgelehnt</literalValue>
        <name>Deal abgelehnt</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Deal_genehmigt</fullName>
        <field>P7S1_ApprovalState__c</field>
        <literalValue>Genehmigt</literalValue>
        <name>Deal genehmigt</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Genehmigungsstatus_in_D</fullName>
        <field>P7S1_ApprovalState__c</field>
        <literalValue>In Diskussion</literalValue>
        <name>Genehmigungsstatus in D</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MT_Set_Status_To_Submitted</fullName>
        <field>P7S1_ApprovalState__c</field>
        <literalValue>Eingereicht</literalValue>
        <name>MT Set Status To Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>P7S1_AccountOwnerApproved</fullName>
        <field>P7S1_ApprovedAccOwner__c</field>
        <literalValue>1</literalValue>
        <name>Account Owner Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>P7S1_BarterApproved</fullName>
        <field>P7S1_ApprovedBarter__c</field>
        <literalValue>1</literalValue>
        <name>Barter Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>P7S1_DSBApproved</fullName>
        <field>P7S1_Approved71MDSB__c</field>
        <literalValue>1</literalValue>
        <name>Rabatt Freigabe Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>P7S1_Eingereicht</fullName>
        <field>P7S1_ApprovalState__c</field>
        <literalValue>Eingereicht</literalValue>
        <name>Eingereicht</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>P7S1_MediaBoardApproved</fullName>
        <field>P7S1_ApprovedMediaboard__c</field>
        <literalValue>1</literalValue>
        <name>Media Board Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>P7S1_RenameOppFreigabe</fullName>
        <field>Name</field>
        <formula>P7S1_Opportunity__r.Name &amp; &quot; - Dealfreigabe&quot;</formula>
        <name>Rename Opp Freigabe</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>P7S1_Zurueckgezogen</fullName>
        <field>P7S1_ApprovalState__c</field>
        <name>Zurückgezogen</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Digital Anteil</fullName>
        <actions>
            <name>Digital_Anteil_Notification</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>send Email to Digital Sales</description>
        <formula>(P7S1_Opportunity__r.P7S1_HasMediaDigital__c &amp;&amp; P7S1_ApprovedAccOwner__c) || (  P7S1_Opportunity__r.P7S1_HasMediaDigital__c &amp;&amp;    P7S1_AccountOwnerUnit__c &lt;&gt; &quot;71M&quot; &amp;&amp;    P7S1_AccountOwnerUnit__c &lt;&gt; &quot;7Ventures&quot; &amp;&amp;    P7S1_AccountOwnerUnit__c &lt;&gt; &quot;Starwatch&quot; &amp;&amp;    P7S1_AccountOwnerUnit__c = $User.P7S1_Unit__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Freigabe in Diskussion</fullName>
        <actions>
            <name>Genehmigungsstatus_in_D</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>P7S1_OpportunityApproval__c.P7S1_ApprovalState__c</field>
            <operation>equals</operation>
            <value>Eingereicht</value>
        </criteriaItems>
        <criteriaItems>
            <field>P7S1_OpportunityApproval__c.P7S1_inDiskussion__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>P7S1_RenameOppFreigabe</fullName>
        <actions>
            <name>P7S1_RenameOppFreigabe</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
